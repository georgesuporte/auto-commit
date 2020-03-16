#!/bin/sh
source './scripts/git-util.sh'
# variable branch:
listBranch[1]="tag"

# List Function:
# Function to execute commit/push tag.
function TagExecute () {
  FindExitsGitTag $1 
  VerifyGitBranch
  if [[ $gitTagExist = false ]]; then
    if [[ $branchID != master ]]; then
      gitCheckoutBranch="$(git checkout master 2>&1)"
    fi
    if [[ $branchID = master ]]; then
      createNewTag $1
    fi
  else
      echo -e "A tag $1 já existe no repositorio." 
      echo "### Lista de Tags ###"
      gitTag="$(git tag  2>&1)"
      echo $gitTag
  fi


}
# End List Function:

# Output
echo "### Tarefas GIT Create TAG"

# Output
echo -e "Por exemplo: 1.3.4.2"
echo -e "     - Versão (Major) = 1"
echo -e "     - Release (Menor) = 3"
echo -e "     - Estabilização (Revision)=4"
echo -e "     - Hotfix (Revision) = 2"
echo -e "Digite o número da tag que deseja criar/comitar:"
# Input
read tagName
TagExecute $tagName



