const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("CertificateVerificationModule", (m) => {
  const cert = m.contract("CertificateVerification");
  return { cert };
});
