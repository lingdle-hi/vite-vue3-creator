#!/bin/bash
# Quick Start for
# Vite + Vue3 + Typescript + Eslint + Prettier
# lint-staged + commit-lint + standard-version
set +e
echoe(){
  echo -e "\033[32m$*\033[0m"
}
APP_NAME="${PWD##*/}"
echoe "start setup $APP_NAME..."

OLD_README="$(cat README.md)"
NEW_README=$'# '$APP_NAME$'
## Quick Start for

> Vite + Vue3 + Typescript + Eslint + Prettier
> lint-staged + commit-lint + standard-version

### 前置条件
- 已安装最新版 node : v14.17.0+
- npm install yarn : 1.22.10+ (不要使用yarn2)
- 了解 语义化版本 公约: https://semver.org/lang/zh-CN/
- 了解 约定式提交 公约: https://www.conventionalcommits.org/zh-hans/v1.0.0/

### 1. create application 仅创建新项目时使用
```bash
./vite-vue3-creator.sh '$APP_NAME$'

```
### 2. run setup 仅第一次初始化项目时运行
```bash
cd '$APP_NAME$'
./setup.sh
```

### 3. workflow: dev -> commit -> release -> push
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
  - WebStorm Prettier 插件设为当前项目 Prettier;启用 On code format 和 On Save'

if [ "$OLD_README" != "$NEW_README" ]
then
echoe "update README.md..."
echo "$NEW_README
$OLD_README
" > README.md
fi

# set git config
echoe "set git config start..."
echo \
"
# eg.  fix(user): fix bug #12345
# types option: feat, fix, docs, style, refactor, perf, test, chore, conflict, revert
# Commit Message 遵循 conventional commits 标准: https://www.conventionalcommits.org/zh-hans/v1.0.0/
# 格式如下：
# ---------------------
# <type>(<scope>): <subject>
# <BLANK LINE>
# <body>
# <BLANK LINE>
# <footer>
# ---------------------
# 标题: <type>(<scope>): <subject>
#   - type: 必须，一个提交类型，从以下选项中选择
#       feat, // 新增功能
#       fix, // bug修复
#       docs, // 文档变更
#       style, // 格式变更
#       refactor, // 代码重构
#       perf, // 性能优化
#       test, // 测试变更
#       chore, // 例行升级
#       conflict, // 解决冲突
#       revert, // 版本回退
#   - scope: 可选，一个模块名称或者范围名称
#   - subject: 必须，一个标题
# 正文: 可为空
#   - 详细描述提交内容
# 脚注: 可为空
#   - 可以是一个问题编号 如: close #1234
#   - BREAKING CHANGE
# ---------------------
# 遵循 conventional commits 标准 ： https://www.conventionalcommits.org/zh-hans/v1.0.0/
# ---------------------
" > .git-commit-template 

set -x
git config --global commit.template .git-commit-template
git config --unset core.hookspath
git config --global core.editor vim
git config --global core.autocrlf input
git config --global core.safecrlf true
set +x
# linter init
echoe "linter init..."
yarn add -D eslint eslint-plugin-vue eslint-plugin-promise eslint-plugin-node eslint-plugin-import @vue/eslint-config-standard @vue/eslint-config-typescript @typescript-eslint/parser @typescript-eslint/eslint-plugin

echo \
"module.exports = {
  root: true,
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: [
    'eslint:recommended', // order by 1
    // 'plugin:vue/recommended', // order by 2 for vue2
    'plugin:vue/vue3-recommended', // order by 2 for vue3
    'plugin:@typescript-eslint/recommended', // order by 3 for typescript
    'plugin:prettier/recommended', // order by end for prettier
  ],
  parser: 'vue-eslint-parser', // must use this parser for vue
  parserOptions: {
    parser: '@typescript-eslint/parser', // use this parser for typescript
    ecmaVersion: 2020, // Allows for the parsing of modern ECMAScript features
    sourceType: 'module', // Allows for the use of imports
    ecmaFeatures: {
      jsx: true, // Allows for the parsing of JSX
    },
  },
  plugins: ['eslint-plugin-prettier', '@typescript-eslint/eslint-plugin'],
  rules: {},
};
" > .eslintrc.js

# prettier init
echoe "prettier init..."
yarn add -D  eslint-plugin-prettier eslint-config-prettier
yarn add -DE prettier
echo \
"module.exports = {
  printWidth: 100, // 单行输出（不折行）的（最大）长度
  tabWidth: 2, // 每个缩进级别的空格数
  useTabs: false, // 不使用缩进符，使用空格
  semi: true, // 在语句末尾使用分号
  singleQuote: true, // 使用单引号
  quoteProps: 'as-needed', // 仅在需要时在对象属性周围添加引号
  jsxSingleQuote: false, // jsx 不使用单引号，而使用双引号
  trailingComma: 'all', // 去除对象最末尾元素跟随的逗号
  bracketSpacing: true, // 是否在对象属性添加空格
  jsxBracketSameLine: true, // 将 > 多行 JSX 元素放在最后一行的末尾（不另起一行）
  arrowParens: 'always', // 箭头函数，始终包括括号 (x) => x
  rangeStart: 0, // 每个文件格式化的范围的开始位置
  rangeEnd: Infinity, // 每个文件格式化的范围的结束位置，rangeStart:0 & rangeEnd:Infinity 表示格式化文件的全部内容
  // parser: null, // 指定解析器，支持自定义 [parser: <string> | parser: require('./my-parser')]
  requirePragma: false, // 禁用只对顶部标记 @format 的代码进行格式化
  insertPragma: false, // 禁用对格式化过的代码顶部插入 @format 标记
  proseWrap: 'always', // 当超出 print width（上面有这个参数）时就折行
  htmlWhitespaceSensitivity: 'ignore', // 指定 HTML 文件的全局空白区域敏感度, 'ignore' - 空格被认为是不敏感的
  vueIndentScriptAndStyle: false, // 关闭 .vue 中嵌入的 script 和 style 的缩进
  endOfLine: 'lf', // 换行符使用 lf
  embeddedLanguageFormatting: 'auto', // 开启自动识别嵌入代码,对 .vue 中的嵌入式代码 script style 进行格式化
};
" > .prettierrc.js


# commitlint init
echoe "commitlint init..."
yarn add -D @commitlint/cli @commitlint/config-conventional
echo \
"module.exports = {
  extends: ['@commitlint/config-conventional'],
  parserPreset: {
    parserOpts: {
      // issue 前缀，自动识别 #1234 为 issue，可在 commit message 中写入关闭的问题 id
      issuePrefixes: ['#'],
    },
  },
  rules: {
    'header-max-length': [0, 'always', 100],
    'type-enum': [
      2,
      'always',
      [
        'feat', // 新增功能
        'fix', // bug修复
        'docs', // 文档变更
        'style', // 格式变更
        'refactor', // 代码重构
        'perf', // 性能优化
        'test', // 测试变更
        'chore', // 例行升级
        'conflict', // 解决冲突
        'revert', // 版本回退
      ],
    ],
  },
};
" > .commitlintrc.js

# standard-version init
echoe "standard-version init..."
yarn add -D standard-version
echo \
"module.exports = {
  header: 'Changelog',
  issueUrlFormat: '{{homepage}}/issues/{{id}}',
  types: [
    { type: 'feat', section: '新增功能', hidden: false },
    { type: 'fix', section: 'bug修复', hidden: false },
    { type: 'docs', section: '文档变更', hidden: false },
    { type: 'style', section: '格式变更', hidden: false },
    { type: 'refactor', section: '代码重构', hidden: false },
    { type: 'perf', section: '性能优化', hidden: false },
    { type: 'test', section: '测试变更', hidden: false },
    { type: 'chore', section: '例行升级', hidden: false },
    { type: 'conflict', section: '解决冲突', hidden: false },
    { type: 'revert', section: '版本回退', hidden: false },
  ],
};
" > .versionrc.js


# lint-staged init
echoe "lint-staged init..."
yarn add -D yorkie lint-staged
npx json-merge-cli \
--src package.json \
--dest package.json \
--params.scripts.lint "eslint . --ext .js,.jsx,.vue,.ts,.tsx -c ./.eslintrc.js" \
--params.scripts.prettier "prettier . --write --ignore-unknown --check --config ./.prettierrc.js" \
--params.scripts.precommit "git add . && git commit" \
--params.scripts.release "standard-version" \
--params.scripts.release:alpha "standard-version --prerelease alpha" \
--params.scripts.release:beta "standard-version --prerelease beta" \
--params.scripts.release:rc "standard-version --prerelease rc" \
--params.gitHooks.commit-msg "commitlint -E GIT_PARAMS" \
--params.gitHooks.pre-commit "lint-staged --verbose --config ./.lintstagedrc.js"
echo \
"module.exports = {
  '*.{js,jsx,vue,ts,tsx}': ['eslint --fix --ext .js,.jsx,.vue,.ts,.tsx -c ./.eslintrc.js ', 'prettier --write --ignore-unknown --check --config ./.prettierrc.js'],
};
" > .lintstagedrc.js

echoe "setup done. now run:
  yarn install
  yarn prettier
  yarn precommit"
exit
