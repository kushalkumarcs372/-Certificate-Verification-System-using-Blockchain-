// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract CertificateVerification is AccessControl {
    bytes32 public constant ADMIN_ROLE = DEFAULT_ADMIN_ROLE;
    bytes32 public constant INSTITUTION_ROLE = keccak256("INSTITUTION_ROLE");

    struct Certificate {
        bytes32 certId;
        bytes32 certHash;
        string institutionName;
        string studentId;
        uint256 issuedAt;
        bool exists;
    }

    mapping(bytes32 => Certificate) private certificatesById;
    mapping(bytes32 => bytes32) private hashToCertId;

    uint256 private certCounter;

    event CertificateIssued(
        bytes32 indexed certId,
        bytes32 indexed certHash,
        string institutionName,
        string studentId,
        uint256 issuedAt
    );

    constructor() {
        _grantRole(ADMIN_ROLE, msg.sender);
    }

    function registerInstitution(address wallet) external onlyRole(ADMIN_ROLE) {
        _grantRole(INSTITUTION_ROLE, wallet);
    }

    function revokeInstitution(address wallet) external onlyRole(ADMIN_ROLE) {
        _revokeRole(INSTITUTION_ROLE, wallet);
    }

    function issueCertificate(
        bytes32 certHash,
        string calldata institutionName,
        string calldata studentId
    ) external onlyRole(INSTITUTION_ROLE) returns (bytes32) {
        require(hashToCertId[certHash] == bytes32(0), "Certificate already issued");

        certCounter++;
        bytes32 certId = keccak256(
            abi.encodePacked(certHash, msg.sender, block.timestamp, certCounter)
        );

        certificatesById[certId] = Certificate({
            certId: certId,
            certHash: certHash,
            institutionName: institutionName,
            studentId: studentId,
            issuedAt: block.timestamp,
            exists: true
        });

        hashToCertId[certHash] = certId;

        emit CertificateIssued(certId, certHash, institutionName, studentId, block.timestamp);

        return certId;
    }

    function verifyCertificateById(bytes32 certId)
        external
        view
        returns (
            bool isValid,
            bytes32 certHash,
            string memory institutionName,
            string memory studentId,
            uint256 issuedAt
        )
    {
        Certificate memory cert = certificatesById[certId];
        if (!cert.exists) {
            return (false, bytes32(0), "", "", 0);
        }
        return (true, cert.certHash, cert.institutionName, cert.studentId, cert.issuedAt);
    }

    function verifyCertificate(bytes32 certHash)
        external
        view
        returns (
            bool isValid,
            bytes32 certId,
            string memory institutionName,
            string memory studentId,
            uint256 issuedAt
        )
    {
        bytes32 id = hashToCertId[certHash];
        if (id == bytes32(0)) {
            return (false, bytes32(0), "", "", 0);
        }
        Certificate memory cert = certificatesById[id];
        return (true, cert.certId, cert.institutionName, cert.studentId, cert.issuedAt);
    }

    function hashExists_(bytes32 certHash) external view returns (bool) {
        return hashToCertId[certHash] != bytes32(0);
    }
}
