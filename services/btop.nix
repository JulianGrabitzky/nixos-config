{ pkgs, ... }:

{
  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    (btop.override {
      cudaSupport = false;
      rocmSupport = true;
    })
    rocmPackages.rocm-smi
  ];

  environment.etc."btop/btop.conf".text = ''
    check_gpu = True
    show_gpu_info = "On"
  '';
}
