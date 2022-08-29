const express = require("express");
const { ethers } = require("ethers");
const axios = require("axios").default;
const app = express();
const port = 3000;

app.get("/gateway", (req, res) => {
  // 1. Import the ABI
  const { abi } = require("./compile.js");

  // 2. Add the Ethers provider logic here:
  const provider = new ethers.providers.JsonRpcProvider();
  const signer = provider.getSigner();

  // 3. Contract address variable
  const contractAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";

  // 4. Create contract instance
  const myContract = new ethers.Contract(contractAddress, abi, provider);

  // 5. Create get function
  const get = async () => {
    console.log(`Making a call to contract at address: ${contractAddress}`);

    // 6. Call contract
    dataBytes = await parseStringToBytes("thong");
    console.log(dataBytes);
    const data = await durin_call(myContract, contractAddress, dataBytes);
    console.log(data);
    console.log(`The current number stored is: ${data}`);
  };

  // 7. Call get function
  get();

  res.send("Hello World!");
});

const parseStringToBytes = (_params) => {
  return ethers.utils.hexlify(ethers.utils.toUtf8Bytes(_params));
};

async function httpcall(urls, to, callData) {
  const args = { sender: to.toLowerCase(), data: callData.toLowerCase() };
  for (const url of urls) {
    const queryUrl = url.replace(/\{([^}]*)\}/g, (match, p1) => args[p1]);
    // First argument is URL to fetch, second is optional data for a POST request.

    let result;
    let res = await axios({
      url: queryUrl,
      method: "get",
      timeout: 8000,
      headers: {
        "Content-Type": "application/json",
      },
    });
    if (res.status == 200) {
      // test for status you want, etc
      console.log(res.status);
      result = res.data;
    }
    // Don't forget to return something
    if (result.statusCode >= 400 && result.statusCode <= 499) {
      throw new Error(data.error.message);
    }
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      return result;
    }

    return result;
  }
}

async function durin_call(contractInstance, to, data) {
  for (let i = 0; i < 4; i++) {
    try {
      return await contractInstance.getData(data);
    } catch (error) {
      if (error.code !== "CALL_EXCEPTION") {
        throw error;
      }

      const { sender, urls, callData, callbackFunction, extraData } =
        error.errorArgs;

      if (sender !== to) {
        throw new Error(
          "Cannot handle OffchainLookup raised inside nested call"
        );
      }
      const { result } = await httpcall(urls, to, callData);
      console.log("adjkasdjjdh", result);

      let ABI = [
        "function MyCallback(bytes calldata response, bytes calldata extraData)",
      ];
      let iface = new ethers.utils.Interface(ABI);
      iface.encodeFunctionData("MyCallback", [result, extraData]);
      console.log("All are done");
    }
  }
  throw new Error("Too many CCIP read redirects");
}

app.get("/getdata", (req, res) => {
  res.status(200).json({ result: 3668 });
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
