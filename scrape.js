import yargs from 'yargs';
import { hideBin } from 'yargs/helpers';
import open from 'open';
import puppeteer from 'puppeteer';

const argv = yargs(hideBin(process.argv)).option('url', {
  alias: 'u',
  describe: 'URL to scrape',
  type: 'string',
  demandOption: true, // URL is required
})
  .option('pricecap', {
    alias: 'p',
    describe: 'Price cap',
    type: 'integer',
    demandOption: false, // URL is required
    default: 2000, // Default to true if not specified
  })
  .argv;


(async () => {
  const scraping_page = argv.url;
  const pricecap = argv.pricecap;

  if (!scraping_page) {
    console.error('Please provide a URL as a command line argument such as \n > node scrape.js --url https://www.apple.com/shop/refurbished/mac/2022-macbook-air-16gb');
    return;
  }

  console.log(`Scrapping page: ${scraping_page}`);

  const browser = await puppeteer.launch({
    args: [
      '--no-sandbox',
    ],
    headless: "new"
  });

  const page = await browser.newPage();
  await page.goto(scraping_page);

  try {
    await page.waitForSelector('.rf-refurb-producttile-currentprice', { timeout: 5000 });

    const prices = await page.$$eval('.rf-refurb-producttile-currentprice', elements => {
      return elements.map(element => ' ' + element.textContent).filter(str => str !== '' && str !== ' ')
    });

    if (prices) {
      const integers = prices.map(price => parseInt(price.replace(/[^0-9]/g, '').slice(0, -2))); // [1549, 1549, 1909]
      console.log(`All Prices: ${integers}`);

      const match = integers.filter(price => price < pricecap);
      if (match.length > 0) {
        console.log(`Matches: ${match}`);
        // opens the url in the default browser 
        open(scraping_page);

      } else {
        console.log('No matches found.');
      }
    } else {
      console.log('Prices element not found or empty.');
    }

  } catch (error) {
    console.log('Error:', error);
  }

  await browser.close();
})();
