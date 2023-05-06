<script>
	import { ethers } from 'ethers';
	import contractABI from '../contracts/QuizGame.json';
	let answer = null;
	let question = null;
	export let web3Props = {
		provider: null,
		signer: null,
		account: null,
		chainId: null,
		contract: null
	};
	export let questionAddr = null;
	$: question = null;
	$: value = null;
	$: funded = value > 0 ? 'question-funded' : 'question-not-funded';
	$: funding = 0;
	let qContract = null;
	async function getQuestion() {
		qContract = new ethers.Contract(questionAddr, contractABI.abi, web3Props.signer);
		console.log(questionAddr);
		question = await qContract.question();
		value = Number(ethers.utils.formatEther(await web3Props.provider.getBalance(questionAddr)));
		qContract.on('QuizFunded', (balance) => {
			value = Number(ethers.utils.formatEther(balance));
		});
		qContract.on('AnswerGuessed', () => {
			getQuestion();
		});
	}
	async function submitGuess() {
		await qContract.guess(answer);
	}

	async function fund() {
		web3Props.signer.sendTransaction({
			to: questionAddr,
			value: ethers.utils.parseEther(funding)
		});
		funding = null;
	}
	getQuestion();
</script>

<div class="{funded} qwrap">
	<div class="question">
		{question}
	</div>
	<div class="value">
		{value} ETH
	</div>
	<input type="text" bind:value={answer} />
	<button on:click={submitGuess} disabled={value <= 0}>Submit Answer</button>
	<br />
	<input type="text" bind:value={funding} />
	<button on:click={fund}>Fund Question</button>
</div>

<style>
	.question-funded {
		background: #4ee44e;
	}
	.question-not-funded {
		background: #ffb6c1;
	}
	.qwrap {
		overflow: hidden;
		position: relative;
		margin-bottom: 1rem;
		padding: 20px;
		border-radius: 15px;
		width: 50%;
		box-shadow: 1px 1px 4px rgb(0, 0, 0, 0.3);
	}
	.question {
		font-size: 2rem;
	}
</style>
