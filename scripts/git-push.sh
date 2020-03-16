#!/bin/sh
source './scripts/git-util.sh'
# variable branch:
listBranch[1]="master"
listBranch[2]="develop"
listBranch[3]="release"

# List Function:
# Function to execute commit branch.
function branchExecute () {
  if [[ $1 = $2 ]];
  then      
      CreateMessage
      SendCommit $message $1
  else
      FindExitsGitBranch $1
      if [[ $branchExists = false ]];
        then
        createNewBranch $1
        # Capture key for value branch.
        for key in "${!listBranch[@]}"; do
          if [[ "${listBranch[$key]}" = $1 ]];
            then
              KeyBranch=$key
          fi 
        done
         # Check KeyBranch not Empty.
         if [[ -n "$KeyBranch" ]]; then
            VerifyGitBranch 
            CheckOptions $KeyBranch
          fi
      else
        echo -e "Você precisa realizar checkout na branch: $1"
      fi 
  fi
}
# Function to verify arguments option.
function CheckOptions () {
  case $1 in
    1) branchExecute "${listBranch[$1]}" $branchID ;;
    2) branchExecute "${listBranch[$1]}" $branchID ;;
    3) branchExecute "${listBranch[$1]}" $branchID ;;
    *) echo "$1 é uma opção invalida!" exit 1 ;;
  esac
}
# End List Function:

# Output
echo "Tarefas GIT"
echo -e "### Voce deve digitar um dos parametros abaixo para realizar o commit automatico: "
echo -e "1 - master"
echo -e "2 - develop"
echo -e "3 - release"

# Output
echo -e "Digite o número da branch que deseja comitar:"

# Input
read branch
VerifyGitBranch
CheckOptions $branch 



