function error(...args: any[]) {
  console.error("[ERROR]", ...args);
}

function info(...args: any[]) {
  console.log("[INFO]", ...args);
}

export default { error, info };
