{
  description = "qemu dev environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          devShell = let
            stdenv = pkgs.llvmPackages_12.stdenv;
            mkShell = pkgs.mkShell.override {
              inherit stdenv;
            };
          in
          mkShell {
            buildInputs = with pkgs; [ gnumake cmake pkg-config python3 libGL openal glew qt5.full xorg.libX11 zlib libusb alsaLib libevdev vulkan-headers vulkan-loader libxml2 SDL2 ocaml libssh2 ];
            shellHook = ''
              export LD_LIBRARY_PATH=${stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
            '';
          };
        }
      );
}

