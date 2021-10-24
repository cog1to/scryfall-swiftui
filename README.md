# Yet another Scryfall frontend for iOS

This is a simple SwiftUI app for iOS to search cards on Scryfall database. It is being written as a hobby project for learning SwiftUI and is not aimed to be commercialized in any form. The code is free for use.

## Features

- Standard Scryfall search, with the same query language.
- Different presentation and sort options, closely mimicing the main site.
- Cross-links from card page back to the search (for Set, Artist, Prinings, etc.)
- Basic cache implementation for images and API calls.
- Adaptive layout for phones and pads.

## Issues

1. The main one is that SVGKit I use for parsing set symbols is failing to parse some of the SVG data. I patched it locally to avoid that, but haven't yet pushed the change to the main reposotory. If you want to fix it in your builds, here's the diff you'll need:

```
diff --git a/Source/Parsers/SVGKPointsAndPathsParser.m b/Source/Parsers/SVGKPointsAndPathsParser.m
index f19da1c..f7fb597 100644
--- a/Source/Parsers/SVGKPointsAndPathsParser.m
+++ b/Source/Parsers/SVGKPointsAndPathsParser.m
@@ -314,6 +313,28 @@ static inline CGPoint SVGCurveReflectedControlPoint(SVGCurve prevCurve)
     return p;
 }
 
++ (CGPoint) readArcFlags:(NSScanner*)scanner
+{
+    CGPoint p;
+    [SVGKPointsAndPathsParser readFlag: scanner intoFloat: &p.x];
+    [SVGKPointsAndPathsParser readFlag: scanner intoFloat: &p.y];
+    return p;
+}
+
++ (void) readFlag:(NSScanner*)scanner intoFloat:(CGFloat*) floatPointer
+{
+    NSUInteger location = [scanner scanLocation];
+
+    // Skip spaces. For some reason readWhitespace doesn't advance scanLocation.
+    while ([scanner.string characterAtIndex: location] == ' ') {
+        location += 1;
+    }
+
+    // Read flag.
+    *floatPointer = ([scanner.string characterAtIndex: location] == '0') ? 0 : 1;
+    [scanner setScanLocation:location + 1];
+}
+
 + (void) readCoordinate:(NSScanner*)scanner intoFloat:(CGFloat*) floatPointer
 {
 #if CGFLOAT_IS_DOUBLE
@@ -832,7 +853,7 @@ static inline CGPoint SVGCurveReflectedControlPoint(SVGCurve prevCurve)
     
     [SVGKPointsAndPathsParser readCommaAndWhitespace:scanner];
  
- CGPoint flags = [SVGKPointsAndPathsParser readCoordinatePair:scanner];
+ CGPoint flags = [SVGKPointsAndPathsParser readArcFlags:scanner];
  
  BOOL largeArcFlag = flags.x != 0.;
  BOOL sweepFlag = flags.y != 0.;

```

2. API search is not 1:1 mapped to the site's search, which is stated in API documentation. Some features are not available, some features I tried to map as closely as I could to the site's behavior. Still, you might get different results when doing a search through the site compared to this app.

## Requirements

iOS 14.3 and XCode 12.3 or newer.

## Deps

- SVGKit

## License

MIT
