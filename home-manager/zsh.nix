{pkgs, lib, ...}:
let
    p10kTheme = "$HOME/.p10k.zsh";
in
{
    home.file.".p10k.zsh".source = ./p10k.zsh;
    programs.zsh = {
        enable = true;
        dotDir = ".config/zsh";
        initExtra = ''
            [[ ! -f ${p10kTheme} ]] || source ${p10kTheme}
            uwufetch -i
        '';
        shellAliases = {
            ocp = "cd $(fd -H -td -d 1 . /home/v_raton/git | fzf)";
        };
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
        };
        plugins = [
            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
        ];
    };
}
