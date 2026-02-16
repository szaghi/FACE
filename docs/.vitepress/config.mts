import { defineConfig } from 'vitepress'
import apiSidebar from '../api/_sidebar.json'

export default defineConfig({
  base: '/FACE/',
  title: 'FACE Documentation',
  markdown: {
    math: true,
    languages: ['fortran-free-form', 'fortran-fixed-form'],
    languageAlias: {
      'fortran': 'fortran-free-form',
      'f90': 'fortran-free-form',
      'f95': 'fortran-free-form',
      'f03': 'fortran-free-form',
      'f08': 'fortran-free-form',
      'f77': 'fortran-fixed-form',
    },
  },
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Guide', link: '/guide' },
      { text: 'API', link: '/api/' },
    ],
    sidebar: {
      '/guide': [
        {
          text: 'Guide',
          items: [
            { text: 'What is FACE?', link: '/guide#what-is-face' },
            { text: 'A taste of FACE', link: '/guide#a-taste-of-face' },
            { text: 'Usage', link: '/guide#usage' },
            { text: 'Available Colors and Styles', link: '/guide#available-colors-and-styles' },
            { text: 'Install', link: '/guide#install' },
            { text: 'Contributing & releasing', link: '/guide#contributing-releasing' },
            { text: 'Copyrights', link: '/guide#copyrights' },
          ],
        },
      ],
      '/api/': [
        {
          text: 'API Reference',
          items: [
            { text: 'Overview', link: '/api/' },
          ],
        },
        ...apiSidebar,
      ],
    },
    search: {
      provider: 'local',
    },
  },
})
