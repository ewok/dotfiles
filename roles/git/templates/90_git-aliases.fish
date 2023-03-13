if status is-interactive
  set -gx _git_log_medium_format '%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
  set -gx _git_log_oneline_format '%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n'
  set -gx _git_log_brief_format '%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n'
  set -gx _git_log_some '%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'
end

function __git_abbr_init

  if test "$__git_abbr_inited" = 1
    return
  end

  set -g __git_abbr_inited 1

  abbr -a g git

  # Working with remote
  abbr -a gR  'git remote'
  abbr -a gRa 'git remote add'
  abbr -a gRl 'git remote --verbose'
  abbr -a gRm 'git remote rename'
  abbr -a gRp 'git remote prune'
  abbr -a gRs 'git remote show'
  abbr -a gRu 'git remote update'
  abbr -a gRx 'git remote rm'

  # Working with branch
  abbr -a gb  'git branch'
  abbr -a gba 'git branch --all --verbose'
  abbr -a gbc 'git checkout -b'
  abbr -a gbl 'git branch --verbose'
  abbr -a gbL 'git branch --all --verbose'
  abbr -a gbm 'git branch --move'
  abbr -a gbM 'git branch --move --force'
  abbr -a gbs 'git show-branch'
  abbr -a gbS 'git show-branch --all'
  abbr -a gbv 'git branch --verbose'
  abbr -a gbV 'git branch --verbose --verbose'
  abbr -a gbx 'git branch --delete'
  abbr -a gbX 'git branch --delete --force'

  # Working with commit
  abbr -a gc    'git commit --verbose'
  abbr -a gcm   'git commit --message'
  abbr -a gcam  'git commit --verbose --amend'
  abbr -a gcf   'git commit --amend --reuse-message HEAD'
  abbr -a gcs   'git show'
  abbr -a gcr   'git revert'

  abbr -a gcA   'git commit --verbose --all'
  abbr -a gcAm  'git commit --all --message'

  abbr -a gcS   'git commit -S --verbose'
  abbr -a gcSam 'git commit -S --verbose --amend'
  abbr -a gcSA  'git commit -S --verbose --all'
  abbr -a gcSm  'git commit -S --message'
  abbr -a gcSs  'git show --pretty=short --show-signature'
  abbr -a gcSl  'git show --pretty=short --show-signature'

  abbr -a gco   'git checkout'
  abbr -a gcoo  'git checkout --ours --'
  abbr -a gcoO  'git checkout --patch'
  abbr -a gcot  'git checkout --theirs --'

  # Cherry-pick
  abbr -a gCP  'git cherry-pick --no-commit'
  abbr -a gCp  'git cherry-pick --ff'
  abbr -a gCs  'git cherry -v'
  abbr -a gCss 'git cherry -v --abbrev'

  # Fetch
  abbr -a gf   'git fetch'
  abbr -a gfA  'git fetch --all'
  abbr -a gfc  'git clone'
  abbr -a gfcr 'git clone --recurse-submodules'
  abbr -a gfm  'git pull'
  abbr -a gfma 'git pull --autostash'
  abbr -a gfr  'git pull --rebase'
  abbr -a gfra 'git pull --rebase --autostash'

  # Index
  abbr -a gia    'git add'
  abbr -a giau   'git add --update'
  abbr -a giA    'git add --patch'
  abbr -a gir    'git reset'
  abbr -a giR    'git reset --patch'
  abbr -a gid    'git diff --no-ext-diff --cached'
  abbr -a giD    'git diff --no-ext-diff --cached --word-diff'
  abbr -a gii    'git update-index --assume-unchanged'
  abbr -a giI    'git update-index --no-assume-unchanged'
  abbr -a gix    'git rm -r --cached'
  abbr -a giX    'git rm -rf --cached'

  # Log
  abbr -a gl     'git log --topo-order --pretty=format:"$_git_log_medium_format"'
  abbr -a glb    'git log --topo-order --pretty=format:"$_git_log_brief_format"'
  abbr -a gls    'git log --topo-order --stat --pretty=format:"$_git_log_medium_format"'
  abbr -a glg    'git log --topo-order --graph --pretty=format:"$_git_log_oneline_format"'
  abbr -a glgs   'git log --topo-order --graph --pretty=format:"$_git_log_oneline_format" --stat'
  abbr -a glgsa  'git log --topo-order --graph --pretty=format:"$_git_log_oneline_format" --stat --all'
  abbr -a glga   'git log --topo-order --graph --pretty=format:"$_git_log_oneline_format" --all'
  abbr -a glgas  'git log --topo-order --graph --pretty=format:"$_git_log_oneline_format" --all --stat'
  abbr -a gldiff 'git log --topo-order --stat --patch --full-diff --pretty=format:"$_git_log_medium_format"'

  abbr -a glo    'git log --topo-order --pretty=format:"$_git_log_oneline_format"'
  abbr -a glog   'git log --date=short --graph --pretty="$_git_log_some"'
  abbr -a gloga  'git log --date=short --graph --pretty="$_git_log_some" --all'
  abbr -a glogat 'git log --graph --pretty="$_git_log_some" --all'
  abbr -a glogt  'git log --graph --pretty="$_git_log_some"'
  abbr -a glogta 'git log --graph --pretty="$_git_log_some" --all'

  abbr -a glS    'git log --show-signature'
  abbr -a glC    'git shortlog --summary --numbered'

  # Merge
  abbr -a gm   'git merge'
  abbr -a gmf  'git merge --ff-only'
  abbr -a gms  'git merge --squash'
  abbr -a gmC  'git merge --no-commit'
  abbr -a gmF  'git merge --no-ff'
  abbr -a gma  'git merge --abort'
  abbr -a gmt  'git mergetool'
  abbr -a gmS  'git merge -S'
  abbr -a gmSf 'git merge -S --ff-only'
  abbr -a gmSs 'git merge -S --squash'

  # Push
  abbr -a gp   'git push'
  abbr -a gpa  'git push --all'
  abbr -a gpat 'git push --all && git push --tags'
  abbr -a gpta 'git push --all && git push --tags'
  abbr -a gpt  'git push --tags'
  abbr -a gpf  'git push --force-with-lease'
  abbr -a gpF  'git push --force'

  # abbr -a gpc 'git push --set-upstream origin "$(git-branch-current 2> /dev/null)"'
  # abbr -a gpp 'git pull origin "$(git-branch-current 2> /dev/null)" && git push origin "$(git-branch-current 2> /dev/null)"'

  # Rebase
  abbr -a gr  'git rebase'
  abbr -a gra 'git rebase --abort'
  abbr -a grc 'git rebase --continue'
  abbr -a gri 'git rebase --interactive'
  abbr -a grs 'git rebase --skip'

  abbr -a gRH 'git reset "HEAD^"'

  # Stash
  abbr -a gs  'git stash'
  abbr -a gsS 'git stash save --patch --no-keep-index'
  abbr -a gsa 'git stash apply'
  abbr -a gsd 'git stash show --patch --stat'
  abbr -a gsl 'git stash list'
  abbr -a gsp 'git stash pop'
  abbr -a gss 'git stash save --include-untracked'
  abbr -a gsw 'git stash save --include-untracked --keep-index'
  abbr -a gsx 'git stash drop'

  # Tag
  abbr -a gt  'git tag'
  abbr -a gtl 'git tag -l'
  abbr -a gts 'git tag -s'
  abbr -a gtv 'git verify-tag'

  # Workdir
  abbr -a gwa 'git add'
  abbr -a gwc 'git clean -n'
  abbr -a gwC 'git clean -f'
  abbr -a gwd 'git diff --no-ext-diff'
  abbr -a gwD 'git diff --no-ext-diff --word-diff'
  abbr -a gwr 'git reset --soft'
  abbr -a gwR 'git reset --hard'
  abbr -a gws 'git status'
  abbr -a gwx 'git rm -r'
  abbr -a gwX 'git rm -rf'

  # Worktree
  abbr -a gWa 'git worktree add'
  abbr -a gWl 'git worktree list'
  abbr -a gWm 'git worktree move'
  abbr -a gWp 'git worktree prune'
  abbr -a gWx 'git worktree remove'

end

__git_abbr_init
