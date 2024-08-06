import{_ as s,c as i,o as a,a7 as t}from"./chunks/framework.BZeboqmr.js";const u=JSON.parse('{"title":"Creating Composites","description":"","frontmatter":{},"headers":[],"relativePath":"examples/basics.md","filePath":"examples/basics.md","lastUpdated":null}'),e={name:"examples/basics.md"},n=t(`<h1 id="Creating-Composites" tabindex="-1">Creating Composites <a class="header-anchor" href="#Creating-Composites" aria-label="Permalink to &quot;Creating Composites {#Creating-Composites}&quot;">​</a></h1><p>This tutorial shows you how to set up different composite scores.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> RheumaComposites</span></span></code></pre></div><p>Creating composites requires specifying the units of some components.</p><p>This protects us from accidentally specifying a DAS28 score on a 0-10 cm visual analogue scale (VAS), or vice versa, an SDAI on a 0-100 mm (VAS). The only exception are joint counts, which are simply integers.</p><p>We will use <a href="https://painterqubits.github.io/Unitful.jl/stable/" target="_blank" rel="noreferrer"><code>Unitful.jl</code></a> for specifying units throughout.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Unitful</span></span></code></pre></div><p>Creating units is easy thanks to the <a href="https://painterqubits.github.io/Unitful.jl/stable/manipulations/#Unitful.@u_str" target="_blank" rel="noreferrer"><code>@u_str</code></a> macro.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">18</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">u</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;mm&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">64</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">u</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;mg/L&quot;</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>(18 mm, 64 mg L^-1)</span></span></code></pre></div><p>Converting a unitless value stored in a variable is simple, too:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">x </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 7</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">x </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">*</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> u</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;cm&quot;</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>7 cm</span></span></code></pre></div><p>Under the hood, the composites will be converted to the unit matching scoring weights and remission cutoffs. This means that you do not have to remember that SDAI requires a 0-10 cm VAS scale and C-reactive protein in mg/dL, while the DAS28 requires millimeters and mg/L.</p><p>Let&#39;s try this by creating a DAS28CRP composite with patient&#39;s global assessment measured in centimeters:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">das28_cm </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> DAS28CRP</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(t28</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, s28</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">0</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, pga</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">2.2</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">u</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;cm&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, apr</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">4</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">u</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;mg/L&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>\x1B[1mDAS28CRP\x1B[22m</span></span>
<span class="line"><span>  T28: 1</span></span>
<span class="line"><span>  S28: 0</span></span>
<span class="line"><span>  PGA: 22.0 mm</span></span>
<span class="line"><span>  APR: 4 mg L^-1</span></span></code></pre></div><p>As you can see, centimeters were automatically converted to millimeters. Providing the same score in millimeters return the same result:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">das28_mm </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> DAS28CRP</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(t28</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, s28</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">0</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, pga</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">22</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">u</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;mm&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, apr</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">4</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">u</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;mg/L&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">score</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(das28_cm) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">==</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> score</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(das28_mm)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>true</span></span></code></pre></div><p>This principle holds for all supported composites.</p><h2 id="components" tabindex="-1">Components <a class="header-anchor" href="#components" aria-label="Permalink to &quot;Components&quot;">​</a></h2><p>If you are not sure about the component names of a composite, you can check the docstring of that composite for guidance. To see the docstring, first hit <code>?</code> in the REPL, then type the name of the composite, and hit enter.</p><p>This is all we need to explore the most important aspects of many different composite scores!</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">sdai </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> SDAI</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(s28</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">3</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, t28</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">4</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, pga</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">34</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">u</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;mm&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, ega</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">28</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">u</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;mm&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, crp</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">21</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">u</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;mg/L&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>\x1B[1mSDAI\x1B[22m</span></span>
<span class="line"><span>  T28: 4</span></span>
<span class="line"><span>  S28: 3</span></span>
<span class="line"><span>  PGA: 17//5 cm</span></span>
<span class="line"><span>  EGA: 14//5 cm</span></span>
<span class="line"><span>  CRP: 21//10 mg dL^-1</span></span></code></pre></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">score</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(sdai), </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isremission</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(sdai), </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">categorise</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(sdai)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>(15.3, false, &quot;Moderate&quot;)</span></span></code></pre></div><hr><p><em>This page was generated using <a href="https://github.com/fredrikekre/Literate.jl" target="_blank" rel="noreferrer">Literate.jl</a>.</em></p>`,30),p=[n];function h(l,k,o,d,r,c){return a(),i("div",null,p)}const y=s(e,[["render",h]]);export{u as __pageData,y as default};
