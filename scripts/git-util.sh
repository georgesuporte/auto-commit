#!/bin/sh
dir=$PWD # Returns directory.
baseproject="$(dirname $dir)"   # Returns base directory.
projectName="$(basename $dir)"  # Returns project name directory.

# List Function:
# Function to create new branch.
function createNewBranch () {
  read -p "### Branch Informada não existe. Deseja Criar? (S/N) " cont
  if [ $cont = "S" ] || [ $cont = "s" ]; then
    gitCreatebranch="$(git checkout -b $1 2>&1)"
    gitPushbranch="$(git push -u origin $1 2>&1)"
    echo "$gitCreatebranch"
    echo "$gitPushbranch"
    # Output
    echo -e "Branch criada com sucesso."
  fi
}
# Function to create new tag.
function createNewTag () {
  read -p "### Tag Informada não existe. Deseja Criar? (S/N) " cont
  if [ $cont = "S" ] || [ $cont = "s" ]; then
    gitCreatebranch="$(git tag -a v$1 -m "$projectName v$1"  2>&1)"
    gitPushbranch="$(git push -u origin v$1 2>&1)"
    echo "$gitCreateTag"
    echo "$gitPushbranch"
    # Output
    echo -e "Tag criada com sucesso."
  fi
}
# Function to verify current branch.
function VerifyGitBranch() { 
   branchID="$(git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3)"
}
# Function to exists current branch.
function FindExitsGitBranch () { 
  branchExists=false
  # Remove os comentarios.
  listGitBranch=$(git branch | sed 's/* //g')
  # Percorre as linhas do arquivo e transforma o conteudo das variaveis em array.
  while read -r line; do 
    gitListBranch+=("$line")
  done <<< "$listGitBranch"
  # Percorre o Array e verifica se a branch existe.
  for ((i = 0 ; i < ${#gitListBranch[@]} ; i++)); do
    resultBranch=$(echo "${gitListBranch[$i]}" | grep  $1 )
    if [[ -n "$resultBranch" ]]; then
        branchExists=true
    fi
  done
}
# Function to verify tag
function VerifyGitTag () {
  listGitTag="$(git tag  2>&1 | sed 's/[v]*//g')"
}
# Function to exists current tag
function FindExitsGitTag () { 
  gitTagExist=false
  # retorna a lista de tags. "$(git tag  2>&1 | sed 's/* //g' | awk "/$1/" | awk -v RS=0 'END{print NR}')"
  VerifyGitTag $listGitTag
  # Percorre as linhas do arquivo e transforma o conteudo das variaveis em array.
  while read -r line; do 
    listTag+=("$line")
  done <<< "$listGitTag"
  # Percorre o Array e verifica se a branch existe.
  for ((i = 0 ; i < ${#listTag[@]} ; i++)); do
    resultTag=$(echo "${listTag[$i]}" | grep  $1 )
    if [[ -n "$resultTag" ]]; then
        gitTagExist=true
    fi
  done
}
# Function to maker Message Commit.
function CreateMessage () { # Validate S.O
  if [[ "$(systeminfo | awk '/Microsoft Corporation/' | awk -v RS=0 'END{print NR}')" -ge 1 ]]; then
    message="auto-commit from $USERNAME on $(date)"
  elif [[ "$(uname | awk '/Linux/' | awk -v RS=0 'END{print NR}')" -ge 1 ]]; then
    message="auto-commit from $USER on $(date)"
  fi
}
# Function to send to the origin repository.
function SendCommit () {
  read -p "### Deseja realizar o commit? (S/N) " cont
  if [ $cont = "N" ] || [ $cont = "n" ]; then
    echo -e "Saindo..."
    exit 1
  else 
    read -p "### Deseja forcar o commit? (S/N) " cont
    git add .
    git commit -m "$message"
    if [ $cont = "N" ] || [ $cont = "n" ]; then
      gitPush="$(git push -u origin $branchID 2>&1)"
    else 
      gitPush="$(git push -f -u origin $branchID 2>&1)"
    fi
    echo "$gitPush"
    exit 0
  fi
}
# End List Function:



