import postcss from "postcss";
import DoIUse from "doiuse/lib/DoIUse.js";
import fs from "fs";

let fail = false;

const runner = postcss(
  new DoIUse({
    browsers: [
      "Explorer >= 10",
      "Firefox >= 59",
      "Safari >= 12.2",
      "UCAndroid >= 15.5",
      "and_qq >= 13.1",
      "kaios >= 2.6",
      "Samsung >= 6",
      "Edge >= 88",
      "Chrome >= 55",
      "Opera >= 42",
      "iOS >= 12.6",
      "Android >= 115",
      "op_mob >= 73",
      "ChromeAndroid >= 115",
      "FirefoxAndroid >= 115",
    ],
    ignore: [
      // ignore cause latest safari just doesnt support them
      "css-touch-action",
      "css3-cursors",
      // ignore cause IE just doesnt support them, but its fine
      "mdn-text-decoration-shorthand",
      "css-rrggbbaa",
      "css-filters",
      "css-placeholder",
    ],
    onFeatureUsage: (usageInfo) => {
      if (usageInfo.featureData.missing) {
        console.log(usageInfo.message);
        fail = true;
      }
    },
  }),
);

await Promise.all(
  fs.readdirSync("./stylesheets/").map(async (file) => {
    const path = `./stylesheets/${file}`;
    await runner.process(fs.readFileSync(path, "utf8"), { from: path });
  }),
);

if (fail) {
  process.exit(1);
}
