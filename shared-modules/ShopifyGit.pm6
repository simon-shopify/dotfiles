unit module ShopifyGit;

sub git(*@args) is export {
    say("  {@args}");
    run("git", |@args) or die;
}

sub add-branch-to-fetch($branch-name) is export {
    git(
        "config",
        "--add", "remote.origin.fetch",
        "+refs/heads/{$branch-name}:refs/remotes/origin/{$branch-name}",
    );
}
