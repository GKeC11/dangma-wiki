import { defineConfig } from 'vitepress'

export default defineConfig({
  lang: 'zh-CN',
  title: 'Dangma Wiki',
  description: '个人游戏攻略、机制研究与实战心得 Wiki',
  base: '/dangma-wiki/',
  cleanUrls: true,
  lastUpdated: true,
  head: [
    ['meta', { name: 'theme-color', content: '#7b1f1f' }],
    ['link', { rel: 'icon', href: '/dangma-wiki/favicon.svg', type: 'image/svg+xml' }]
  ],
  themeConfig: {
    logo: '/favicon.svg',
    siteTitle: 'Dangma Wiki',
    nav: [
      { text: '首页', link: '/' },
      { text: '游戏目录', link: '/games/' },
      { text: '战锤3', link: '/games/total-war-warhammer-3/' },
      { text: '震旦', link: '/games/total-war-warhammer-3/cathay/' }
    ],
    sidebar: {
      '/games/': [
        {
          text: '游戏目录',
          items: [
            { text: '全部游戏', link: '/games/' },
            { text: '全面战争：战锤3', link: '/games/total-war-warhammer-3/' }
          ]
        }
      ],
      '/games/total-war-warhammer-3/': [
        {
          text: '全面战争：战锤3',
          items: [
            { text: '游戏首页', link: '/games/total-war-warhammer-3/' },
            { text: '发展、经济与招募', link: '/games/total-war-warhammer-3/basics/development' }
          ]
        },
        {
          text: '震旦',
          items: [
            { text: '势力首页', link: '/games/total-war-warhammer-3/cathay/' },
            { text: '长垣关隘建设', link: '/games/total-war-warhammer-3/cathay/campaign/great-bastion' }
          ]
        },
        {
          text: '单位百科',
          collapsed: false,
          items: [
            { text: '兵表特点与快速结论', link: '/games/total-war-warhammer-3/cathay/units/' },
            { text: '多维能力排名', link: '/games/total-war-warhammer-3/cathay/units/rankings' },
            { text: '完整单位角色速查', link: '/games/total-war-warhammer-3/cathay/units/roles' },
            { text: '常见问题与资料来源', link: '/games/total-war-warhammer-3/cathay/units/faq' }
          ]
        },
        {
          text: '配兵与阵型',
          items: [
            { text: '军队编制与操作', link: '/games/total-war-warhammer-3/cathay/army/compositions' }
          ]
        },
        {
          text: '领主与英雄流派',
          items: [
            { text: '栏目首页', link: '/games/total-war-warhammer-3/cathay/characters/' },
            { text: '妙影流派', link: '/games/total-war-warhammer-3/cathay/characters/miao-ying' },
            { text: '司天丞', link: '/games/total-war-warhammer-3/cathay/characters/astromancer' },
            { text: '普通领主对比', link: '/games/total-war-warhammer-3/cathay/characters/generic-lords' }
          ]
        }
      ]
    },
    outline: { level: [2, 3], label: '本页目录' },
    search: {
      provider: 'local',
      options: {
        locales: {
          root: {
            translations: {
              button: { buttonText: '搜索 Wiki', buttonAriaLabel: '搜索 Wiki' },
              modal: {
                noResultsText: '没有找到相关内容',
                resetButtonTitle: '清除查询',
                footer: { selectText: '选择', navigateText: '切换', closeText: '关闭' }
              }
            }
          }
        }
      }
    },
    docFooter: { prev: '上一篇', next: '下一篇' },
    lastUpdated: { text: '最后更新于' },
    socialLinks: []
  }
})
