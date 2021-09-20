const pinataApiKey = "key";
const pinataSecretApiKey = "secrete";
const axios = require("axios");
const fs = require("fs");
const FormData = require("form-data");

// import { post } from "axios";
// import { createReadStream } from "fs";
// import FormData from "form-data";

const pinFileToIPFS = async () => {
    const url = `https://api.pinata.cloud/pinning/pinFileToIPFS`;

    let data = new FormData();

    data.append("file", fs.createReadStream("./nft-test.jpeg"));
7
    const res = await axios.post(url, data, {
        maxContentLength: "Infinity",
        headers: {
            "Content-Type": `multipart/form-data; boundary=${data._boundary}`,
            pinata_api_key: pinataApiKey,
            pinata_secret_api_key: pinataSecretApiKey,
        },
    }).then(function(response) {
        console.log(response);
    }).catch(function(error) {
        console.log(error)
    });

    console.log(res.data);
};

pinFileToIPFS();