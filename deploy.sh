git add .
git stash
git switch -C deploy
git rm -rf .
find . -maxdepth 1 -not -path './.git*' -not -path '.' -exec rm -rf {} +
git checkout main -- .

cd Scripts && npm install && cd ../
swift run blog ./

find . -maxdepth 1 -not -path './.html*' -not -path './.git*' -not -path '.' -exec rm -rf {} +

cp -r .html/* .
rm -rf .html

git add .
git commit -m "Deploy $(date +"%Y-%m-%d")"

git push origin deploy --force
git switch -
git stash pop
