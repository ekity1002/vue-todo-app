# vue 用 dockerfile
# https://jp.vuejs.org/v2/cookbook/dockerize-vuejs-app.html
FROM node:lts-alpine3.16

# vite make project template
# RUN npm create vite@latest . -- --template  vue
# npm でやったらエラーになった。yarn
RUN yarn create vite todo-app --template vue

# カレントワーキングディレクトリ
WORKDIR /app/

# # プロジェクトの依存ライブラリをインストールする
# RUN yarn install

# CMD [ "yarn", "dev" ]