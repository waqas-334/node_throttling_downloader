const express = require("express");
const path = require("path");
const fs = require("fs");
const { Throttle } = require("stream-throttle"); // Throttling stream module

const app = express();
const PORT = 3000;

// Set a throttle rate of 100 KB/s (100 * 1024 bytes per second)
const downloadSpeedLimit = 100 * 1024; // 100 KB/s

app.get("/download", (req, res) => {
  const filePath = path.join(__dirname, "files", "example.pdf"); // Path to the file

  // Check if the file exists
  if (fs.existsSync(filePath)) {
    const fileStream = fs.createReadStream(filePath); // Create a read stream for the file
    const throttle = new Throttle({ rate: downloadSpeedLimit }); // Throttle the stream to 100 KB/s

    // Set headers to force download
    res.setHeader(
      "Content-Disposition",
      'attachment; filename="downloadedFile.pdf"'
    );
    res.setHeader("Content-Type", "application/pdf");

    // Pipe the file through the throttle and then to the response
    fileStream.pipe(throttle).pipe(res);
  } else {
    res.status(404).send("File not found");
  }
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
