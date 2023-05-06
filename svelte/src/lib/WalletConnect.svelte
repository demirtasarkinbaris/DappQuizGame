<script>
	import { ethers } from 'ethers';
	export let web3Props = {
		provider: null,
		signer: null,
		account: null,
		chainId: null,
		contract: null
	};
	export let contractAddr = '';
	export let contractABI = { abi: null };
	async function connectWallet() {
		let provider = new ethers.providers.Web3Provider(window.ethereum);
		await provider.send('eth_requestAccounts', []);
		const signer = provider.getSigner();
		const account = await signer.getAddress();
		const chainId = await signer.getChainId();
		const contract = new ethers.Contract(contractAddr, contractABI.abi, signer);
		web3Props = { provider, signer, account, chainId, contract };
	}
</script>

<button on:click={connectWallet}>Attach Wallet</button>
