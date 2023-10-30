const price = () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1 );
    const addPofitDom = document.getElementById("profit");
    addPofitDom.innerHTML = Math.floor(priceInput.value - Math.floor(priceInput.value * 0.1 ))
  })
};

window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);

//バリデーションエラーのページでJavascriptが発火していなかったので、13行目のturbo:render を入れて修正しました。挙動は確認しています。
//記述をシンプルにするために、定数priceを定義しました。
