{
    config = {
        programs.git.aliases = {
            ci = "commit";
            reword = "commit --amend";
            st = "status --short";
            sw = "switch";
            new = "switch --create";
            b = "branch";
            del = "branch --delete";
            list = "branch --all";
            hist = "log --graph --oneline --all";
            undo = "reset HEAD~";
            unstage = "reset HEAD";
            m = "merge";
            ff = "merge --ff";
            changes = "diff --cached";
        };
    };
}
