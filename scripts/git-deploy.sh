#!/bin/sh
source './scripts/git-util.sh'
# variable branch:
listBranch[0]="develop"
listBranch[1]="release"
listBranch[2]="master"
# List Function:
# Function to auto merge branch.
function MergeExecute () {
   verifyBranch
    for ((i = 1; i < ${#listBranch[@]} ; i++)); do
        echo "${listBranch[$i]} =====> "${listBranch[$i]}
        gitCheckout="$(git checkout ${listBranch[$i]} 2>&1)"
        gitCheckoutBranch="$(git merge ${listBranch[$i-1]} 2>&1)"
        gitPushBranch="$(git push -u origin ${listBranch[$i]} 2>&1)"
        echo "$gitCheckout"
        echo "$gitCheckoutBranch"
        echo "$gitPushBranch" 
        echo -e "### Auto merge realizado ### "
    done
    read -p "### Deseja Criar Tag? (S/N) " cont
    if [ $cont = "S" ] || [ $cont = "s" ]; then
        source './scripts/git-tag-push.sh'
    fi
    verifyBranch
}
# Function to verify branch
function verifyBranch() {
     VerifyGitBranch
    if [[ $branchID != ${listBranch[0]} ]]; then
        gitCheckout="$(git checkout ${listBranch[0]} 2>&1)"
        echo $gitCheckout
    fi
}
# End List Function:
MergeExecute