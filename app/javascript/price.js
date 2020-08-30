window.addEventListener("load", () => {
  let input = document.getElementById("item-price");
  let calculated_price1 = document.getElementById("add-tax-price");
  let calculated_price2 = document.getElementById("profit");


  input.addEventListener("input",(e) => {
    let price = input.value;
    let tax = price * 0.1;
    let profit = price - tax;
    calculated_price1.innerHTML = tax.toFixed();
    calculated_price2.innerHTML = profit.toFixed();
    e.preventDefault();
  })
})