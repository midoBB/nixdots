{
  pkgs,
  fetchurl,
  callPackage,
}: let
  buildGraalvm =
    callPackage
    "${pkgs.path}/pkgs/development/compilers/graalvm/community-edition/buildGraalvm.nix";

  graalvm21 =
    (buildGraalvm {
      version = "21.3.1";
      javaVersion = "21";
      src = fetchurl {
        url = "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-21.0.0/graalvm-community-jdk-21.0.0_linux-x64_bin.tar.gz";
        sha256 = "sha256-bEIpQczFi+W4kbtkmf7rcs0rdNZymim/H7jMGn1Ysxk=";
      };
      meta.platforms = ["x86_64-linux"];
    })
    .overrideAttrs {doInstallCheck = false;};
in {
  graalvm21-ce = graalvm21;
}
