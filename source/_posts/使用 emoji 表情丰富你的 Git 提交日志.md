---
title: 使用 emoji 表情丰富你的 Git 提交日志
date: 2021-11-28 17:00:38
urlName: git_emoji_commit
tags:
    - git
    - emoji
---
Git

在使用emoji 提交日志的时候推荐信息遵循以下格式：

:emoji1: :emoji2: 不超过 50 个字的摘要，首字母大写，使用祈使语气，句末不要加句号 引用相关 issue 或 PR 编号 

初次提交示例：
> git commit -m ":tada: Initialize Repo"

<!--more-->

### emoji 指南
| emoji | emoji 代码 | commit 说明 |
| --- | --- | --- |
| 🎉(庆祝) | `:tada:` | 初次提交 |
| 🆕(全新)✨ (新特性) | `:new:``:sparkles:`  | 引入新功能 |
| 🔖(书签) | `:bookmark:` | 发行/版本标签 |
| 🐛(bug) | `:bug:` | 修复 bug |
| 🚑(急救车) | `:ambulance:` | 重要补丁 |
| 🌐(地球) | `:globe_with_meridians:` | 国际化与本地化 |
| 💄(口红) | `:lipstick:` | 更新 UI 和样式文件 |
| 🎬(场记板) | `:clapper:` | 更新演示/示例 |
| 🚨(警车灯) | `:rotating_light:` | 移除 linter 警告 |
| 🔧(扳手) | `:wrench:` | 修改配置文件 |
| ➕(加号) | `:heavy_plus_sign:` | 增加一个依赖 |
| ➖(减号) | `:heavy_minus_sign:` | 减少一个依赖 |
| ⬆️(上升箭头) | `:arrow_up:` | 升级依赖 |
| ⬇️(下降箭头) | `:arrow_down:` | 降级依赖 |
| ⚡(闪电)🐎(赛马) | `:zap:``:racehorse:` | 提升性能 |
| 📈(上升趋势图) | `:chart_with_upwards_trend:` | 添加分析或跟踪代码 |
| 🚀(火箭) | `:rocket:` | 部署功能 |
| ✅(白色复选框) | `:white_check_mark:` | 增加测试 |
| 📝(备忘录)📖(书) | `:memo:``:book:` | 撰写文档 |
| 🔨(锤子) | `:hammer:` | 重大重构 |
| 🎨(调色板) | `:art:` | 改进代码结构/代码格式 |
| 🔥(火焰) | `:fire:` | 移除代码或文件 |
| ✏️(铅笔) | `:pencil2:` | 修复 typo |
| 🚧(施工) | `:construction:` | 工作进行中 |
| 🗑️(垃圾桶) | `:wastebasket:` | 废弃或删除 |
| ♿(轮椅) | `:wheelchair:` | 可访问性 |
| 👷(工人) | `:construction_worker:` | 添加 CI 构建系统 |
| 💚(绿心) | `:green_heart:` | 修复 CI 构建问题 |
| 🔒(锁) | `:lock:` | 修复安全问题 |
| 🐳(鲸鱼) | `:whale:` | Docker 相关工作 |
| 🍎(苹果) | `:apple:` | 修复 macOS 下的问题 |
| 🐧(企鹅) | `:penguin:` | 修复 Linux 下的问题 |
| 🏁(旗帜) | `:checkered_flag:` | 修复 Windows 下的问题 |
| 🔀(交叉箭头) | `:twisted_rightwards_arrows:` | 分支合并 |

<a name="ySdxc"></a>
### 
<a name="dszXv"></a>
### 如何在命令行中显示 emoji

默认情况下，在命令行中并不会显示出 emoji, 仅显示 emoji 代码。不过可以使用 [emojify](https://github.com/mrowa44/emojify) 使得在命令行也可显示 emoji, 它是一个 shell 脚本，安装与使用都很简单 下载此文件 [https://raw.githubusercontent.com/mrowa44/emojify/master/emojify](https://raw.githubusercontent.com/mrowa44/emojify/master/emojify), 将Shell脚本放在你的PATH 环境中，并赋予可执行权限，然后使用如下命令测试

```bash
~/sdk/shell
❯ ls -lah
total 208
drwxr-xr-x  3 zhoutao  staff    96B 12 11 16:36 .
drwxr-xr-x  5 zhoutao  staff   160B 12 11 16:35 ..
-rwxr-xr-x  1 zhoutao  staff   100K 12 11 16:36 emojify

~/sdk/shell
❯ emojify "Hey, I just :raising_hand:  you, and this is :scream:  , but here's my :calling:  , so :telephone_receiver:  me, maybe?"
Hey, I just 🙋  you, and this is 😱  , but here's my 📲  , so 📞  me, maybe?
```

在使用 git bash 的时候，设置替换日志中的表情符号代码, 当然也可以使用 alias 等其他别名方式实现更简短的命令

```bash
$ git log --oneline --color | emojify | less -r
$ alias glog='git log --oneline --color | emojify | less -r'

# 测试结果
a90277504 ✨ 新增 创建支付方式的校验逻辑
6615a2eff 🔀  合并多支付方式分支
4d3e60188 ✨ 完成订单多支付方式的功能
046eae7e9 🐛 修复订单追加后处理人的bug
88be771df refactor(account): update
823f16c28 ✨ 完成订单支付方式
61cc72048 🐛 修复订单导出的缺少销售代表的bug
23c54aa30 refactor(account): update
dc133fc9d 🐛 修复订单导出缺少客户名称以及销售代表的问题 & 修复客服更新订单未指派为销售客户的问题
```




