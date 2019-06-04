<!-- Nothing should change here after auto-indentation -->

<svelte:head>
    <title>Foo</title>
</svelte:head>

<Foo/>
<Foo {bar}/>
<Foo bar={bar}/>
<Foo bar="{bar}"/>

<foo/>
<foo {bar}/>
<foo bar={bar}/>
<foo bar="{bar}"/>

<Foo>
    <Bar/>
</Foo>
<Foo>
    <Bar></Bar>
</Foo>
<Foo>
    <bar/>
</Foo>
<Foo>
    <bar></bar>
</Foo>

<foo>
    <Bar/>
</foo>
<foo>
    <Bar></Bar>
</foo>
<foo>
    <bar/>
</foo>
<foo>
    <bar></bar>
</foo>

<style>
</style>

<style>
    foo {bar: baz}
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
    $: baz = $foo + bar
</script>
