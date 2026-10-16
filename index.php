<?php
// Goldsvet Casino Engine Entry Point
if (file_exists('slot_router.php')) {
    include 'slot_router.php';
} else {
    echo "<h1>Goldsvet Casino Platform is Live!</h1>";
    echo "<p>Core engine connected successfully.</p>";
}
?>
