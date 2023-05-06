<script>
	import { ethers } from 'ethers';
	export let web3Props = {
		provider: null,
		signer: null,
		account: null,
		chainId: null,
		contract: null
	};
	$: question = '';
	$: answer = '';
	$: hashedAnswer = '';

	async function addQuestion() {
		hashedAnswer = ethers.utils.keccak256(
			ethers.utils.solidityPack(
				['bytes32', 'string'],
				[ethers.utils.formatBytes32String('123123123'), answer]
			)
		);
		web3Props.contract.createQuiz(question, hashedAnswer);
	}
</script>

<div class="wrapper">
	<span class="input-label">Question:</span>
	<input bind:value={question} />
	<span class="input-label">Answer:</span>
	<input bind:value={answer} />
	<button on:click={addQuestion}>Add Question</button>
</div>

<style>
	.wrapper {
		overflow: hidden;
		position: relative;
		margin-bottom: 1rem;
		padding: 20px;
		border-radius: 15px;
		width: 33%;
		box-shadow: 1px 1px 4px rgb(0, 0, 0, 0.3);
	}
	.input-label {
		display: inline-block;
		width: 200px;
	}
</style>
