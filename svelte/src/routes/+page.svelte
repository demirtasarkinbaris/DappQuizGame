<script>
	import WalletConnect from '../lib/WalletConnect.svelte';
	import AllQuestions from '../lib/AllQuestions.svelte';
	import AddQuestion from '../lib/AddQuestion.svelte';
	import contractABI from '../contracts/QuizFactory.json';
	import { bind } from 'svelte/internal';
	const contractAddr = '0x29FfEFde64e9Ae3567aB2d3C50184264df9eE217';
	export let web3Props = {
		provider: null,
		accounts: null,
		chainId: null
	};
</script>

<h1>Welcome to My Quiz</h1>
{#if !web3Props.account}
	<WalletConnect bind:web3Props {contractAddr} {contractABI} />
{:else}
	<AddQuestion bind:web3Props />
	<AllQuestions bind:web3Props />
{/if}
