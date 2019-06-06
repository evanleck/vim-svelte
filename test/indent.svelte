<!-- Nothing should change here after auto-indentation -->

<svelte:head>
  <title>Foo</title>
</svelte:head>

<Foo/>
<Foo {bar}/>
<Foo bar={bar}/>
<Foo bar="{bar}"/>

<Foo>
  <Bar/>
</Foo>
<Foo>
  <Bar />
</Foo>
<Foo>
  <Bar></Bar>
</Foo>
<Foo>
  <Bar>
    <Baz />
  </Bar>
</Foo>
<Foo>
  <div>
    <Baz />
  </div>
</Foo>

<Widget.Foo>
  <div>
    <Baz />
  </div>
</Widget.Foo>

<div>
  <Bar/>
</div>
<div>
  <Bar></Bar>
</div>
<div>
  <Bar>
    <span>
    </span>
  </Bar>
</div>

<div>
  <Bar>
  </Bar>
</div>

<style>
</style>

<style>
  foo { bar: baz }
</style>

<style>
  .foo {
    bar: 1;
    baz: 2;
  }
  .foo :global(bar) {
    baz: 1;
  }
</style>

<script context="module">
  export async function preload (page, session) {
    return await this.fetch("/foo").then(r => r.json())
  }
</script>

<script>
  import { foo } from "./stores.js"
  import Foo from "./Foo.svelte"

  export let bar
  const fooBar = 'wat';

  $: baz = $foo + bar
  $: {
    const bar = 'bar'

    if (foo) {
      fooBarBaz()
    }
  }
</script>
