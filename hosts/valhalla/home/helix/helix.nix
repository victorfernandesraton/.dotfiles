{ pkgs, ... }:

{
  home = {
    file = {
      ".config/helix/config.toml".text = /*.toml*/ ''
        theme = "rose_pine"

        [editor]
        line-number = "relative"
        mouse = false

        [editor.cursor-shape]
        insert = "bar"
        normal = "block"
        select = "block"

        [editor.file-picker]
        hidden = false
      '';
    };
  };
}
