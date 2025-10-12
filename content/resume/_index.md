---
title: "简历"
date: 2025-10-12T15:30:00+08:00
draft: false
layout: "page"
description: "专业版个人简历，结构清晰、响应式，适配博客展示场景，便于面试官快速阅读。"
---

<style>
/* 简历内联样式：响应式，两栏布局（桌面）-> 单列（移动）*/
.resume-wrap{max-width:1100px;margin:0 auto;padding:28px 18px;font-family:system-ui,-apple-system,'Segoe UI',Roboto,'Helvetica Neue',Arial,'Noto Sans CJK SC',sans-serif;color:var(--text-color,#111);} 
.resume-top{display:flex;flex-wrap:wrap;align-items:center;gap:16px;border-bottom:1px solid rgba(0,0,0,0.06);padding-bottom:18px;margin-bottom:18px}
.avatar{width:96px;height:96px;border-radius:12px;background:#f2f4f7;display:flex;align-items:center;justify-content:center;font-weight:700;color:#333}
.name{font-size:26px;font-weight:700}
.meta{color:var(--muted,#666);font-size:14px}
.intro{margin-top:8px;font-size:15px;line-height:1.6}
.resume-grid{display:grid;grid-template-columns:320px 1fr;gap:28px;margin-top:18px}
.card{background:transparent}
.side-block{padding:12px;border-radius:8px;background:var(--card-bg,transparent)}
.section-title{font-weight:700;margin-bottom:8px;color:var(--accent,#1f6feb)}
.skill-tags{display:flex;flex-wrap:wrap;gap:8px}
.tag{background:rgba(31,111,235,0.08);color:var(--accent,#1f6feb);padding:6px 10px;border-radius:999px;font-size:13px}
.experience{margin-bottom:18px}
.exp-head{display:flex;justify-content:space-between;align-items:flex-start;gap:12px}
.exp-role{font-weight:700}
.exp-meta{color:var(--muted,#666);font-size:13px}
.bullet{margin:8px 0 0 0;padding-left:18px}
.metrics{color:var(--accent,#1f6feb);font-weight:700}

/* 响应式 */
@media (max-width:900px){
  .resume-grid{grid-template-columns:1fr}
  .avatar{width:72px;height:72px}
  .name{font-size:22px}
}
</style>

<div class="resume-wrap">
  <div class="resume-top">
    <div class="avatar">DN</div>
    <div style="flex:1;min-width:0">
      <div class="name">张三 / 职业头衔（例如：前端工程师）</div>
      <div class="meta">城市 · 手机：+86 138-0000-0000 · 邮箱：youremail@example.com · GitHub: github.com/yourname</div>
      <div class="intro">资深工程师 / 擅长前端架构与性能优化，7 年互联网产品开发经验，曾主导多项关键项目并带领小团队交付高可用产品。习惯使用数据驱动决策，擅长把复杂业务模块拆解为高质量、可维护的工程解决方案。</div>
    </div>
  </div>

  <div class="resume-grid">
    <aside class="card side-block">
      <div class="section">
        <div class="section-title">核心技能</div>
        <div class="skill-tags">
          <span class="tag">JavaScript</span>
          <span class="tag">TypeScript</span>
          <span class="tag">React / Vue</span>
          <span class="tag">Hugo / 静态站点</span>
          <span class="tag">HTML5 / CSS3</span>
          <span class="tag">性能优化</span>
          <span class="tag">单元 & 集成测试</span>
        </div>
      </div>

      <div class="section" style="margin-top:16px">
        <div class="section-title">工具链</div>
        <div class="meta">Git · CI/CD · Docker · Webpack / Vite · ESLint · Prettier</div>
      </div>

      <div class="section" style="margin-top:16px">
        <div class="section-title">教育</div>
        <div class="meta">某某大学 · 计算机科学与技术 · 本科 （2012 - 2016）</div>
      </div>

      <div class="section" style="margin-top:16px">
        <div class="section-title">语言与证书</div>
        <div class="meta">中文（母语）· 英语（熟练） · PMP / AWS CCP（如有）</div>
      </div>
    </aside>

    <main>
      <section class="card" style="margin-bottom:18px">
        <div class="section-title">工作经历</div>

        <article class="experience">
          <div class="exp-head">
            <div>
              <div class="exp-role">高级前端工程师 · 某互联网公司</div>
              <div class="exp-meta">2021.05 — 至今 · 北京</div>
            </div>
            <div class="exp-meta">团队规模：8 人 · 汇报对象：技术负责人</div>
          </div>
          <ul class="bullet">
            <li>主导公司核心产品前端架构重构，将首屏渲染时间缩短 <span class="metrics">40%</span>，页面体积减少 <span class="metrics">35%</span>。</li>
            <li>设计并落地组件化研发流程（基于 TypeScript + Vite），提高组件复用率并把功能交付周期缩短 <span class="metrics">30%</span>。</li>
            <li>搭建前端监控与自动回滚机制，将生产故障恢复时间（MTTR）从平均 <span class="metrics">2.5 小时</span> 降至 <span class="metrics">20 分钟</span>。</li>
          </ul>
        </article>

        <article class="experience">
          <div class="exp-head">
            <div>
              <div class="exp-role">前端工程师 · 另一家公司</div>
              <div class="exp-meta">2018.03 — 2021.04 · 上海</div>
            </div>
            <div class="exp-meta">负责多个落地项目的前端开发与维护</div>
          </div>
          <ul class="bullet">
            <li>参与从零到一搭建 B2B 电商前端平台，承担核心模块开发，用户月活增长 <span class="metrics">120%</span>。</li>
            <li>实现前端国际化方案（i18n），支持 4 种语言，提升海外用户体验并减少人工翻译成本。</li>
          </ul>
        </article>
      </section>

      <section class="card" style="margin-bottom:18px">
        <div class="section-title">项目经验（精选）</div>

        <article class="experience">
          <div class="exp-head">
            <div>
              <div class="exp-role">项目：大流量秒杀系统 · 个人职责：前端架构与性能优化</div>
              <div class="exp-meta">2022.08 — 2023.01</div>
            </div>
            <div class="exp-meta">技术栈：React, TypeScript, Redis, Nginx</div>
          </div>
          <ul class="bullet">
            <li>负责前端限流、缓存与异步加载策略设计，保证高峰期请求下页面可用性，系统在百万级请求下保持 <span class="metrics">99.95%</span> 可用率。</li>
            <li>实现渐进式加载与关键资源预加载，页面响应首屏时间从 <span class="metrics">1.8s</span> 优化至 <span class="metrics">0.9s</span>。</li>
          </ul>
        </article>

        <article class="experience">
          <div class="exp-head">
            <div>
              <div class="exp-role">项目：企业知识库平台 · 个人职责：功能开发与交付</div>
              <div class="exp-meta">2019.06 — 2020.12</div>
            </div>
            <div class="exp-meta">技术栈：Vue, Node.js, Elasticsearch</div>
          </div>
          <ul class="bullet">
            <li>主导全文检索前端集成（Elasticsearch），并参与搜索相关指标优化，使查询延迟降低 <span class="metrics">60%</span>。</li>
            <li>实现权限与版本控制模块，支持团队协作编辑与审阅流程。</li>
          </ul>
        </article>
      </section>

      <section class="card" style="margin-bottom:18px">
        <div class="section-title">其他信息</div>
        <div class="meta">
          Github：<a href="https://github.com/yourname">github.com/yourname</a> · 个人博客：<a href="/">desert98.github.io</a>
        </div>
      </section>
    </main>
  </div>
</div>

<!-- 说明：此模板放在 content/resume/_index.md 中，可直接编辑示例内容为你的真实经历。样式为内联 CSS，易于直接上线；如需更深度定制，我可以把样式迁移到 assets 并制作专用布局。 -->
