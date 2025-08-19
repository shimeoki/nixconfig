{
    config = {
        programs.git.extraConfig = {
            init.defaultBranch = "main";
            core = {
                whitespace = "error";
                preloadIndex = true;
            };
            commit.verbose = true;
            merge = {
                conflictStyle = "zdiff3";
                ff = false;
            };
            diff = {
                colorMoved = "default";
                algorithm = "histogram";
                submodule = "log";
                renames = "copies";
            };
            status = {
                branch = true;
                showStash = true;
                submoduleSummary = true;
            };
            submodule.recurse = true;
            transfer = {
                fsckObjects = true;
            };
            fetch = {
                fsckObjects = true;
                prune = true;
            };
            receive = {
                fsckObjects = true;
            };
            log = {
                date = "iso";
                abbrevCommit = true;
            };
            branch.sort = "-committerdate";
            push = {
                autoSetupRemote = true;
                default = "current";
                followTags = true;
            };
            pull.ff = "only";
            tag.sort = "-taggerdate";
        };
    };
}
