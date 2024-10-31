git switch -C deploy
git rm -rf .
git checkout main -- .

cd Scripts && npm install
swift run blog ./

find . -mindepth 1 -not -path './.html*' -not -path './.git*' -not -path '.' -exec rm -rf {} +

cp -r .html/* .
rm -rf .html

git add .
git commit -m "Deploy $(date +"%Y-%m-%d")"

git push origin deploy --force
git switch -