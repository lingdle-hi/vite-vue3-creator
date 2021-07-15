# vite-vue3-demo
## Quick Start for 

> Vite + Vue3 + Typescript + Eslint + Prettier  
> lint-staged + commit-lint + standard-version

### 前置条件
- 已安装最新版 node : v14.17.0+
- npm install yarn : 1.22.10+ (不要使用yarn2)

### 1. create application 仅创建新项目时使用
```bash
./vite-vue3-creator.sh vite-vue3-demo

```
### 2. run setup 仅第一次初始化项目时运行
```bash
cd vite-vue3-demo
./setup.sh
```

### 3. workflow: dev -> comit -> release -> push
```bash
yarn install
yarn dev
yarn precommit
yarn release:rc
yarn release
git push
```

### 4. other scripts
```bash
yarn dev
yarn build
yarn serve

yarn lint
yarn prettier
yarn precommit

yarn release
yarn release:alpha
yarn release:beta
yarn release:rc
```

### 常见问题
- 需要转换个别文件的(yarn.lock) CRLF > LF 
- 需要启用 WebStorm/ide/VSCode 的 eslint/prettier 插件配置
  - pattern : `{**/*,*}.{js,ts,jsx,tsx,html,vue}`
  - WebStorm eslint 插件设为 Automatic Eslint configuration, 禁用 Run eslint --fix on Save
  - WebStorm Prettier 插件设为当前项目 Prettier;启用 On code format 和 On Save
