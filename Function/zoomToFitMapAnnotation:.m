
-(void)zoomToFitMapAnnotations:(BOOL)animated {
    if([self.mappaView.annotations count] == 0)
        return;
    bool atLeastOne = false;
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(id<MKAnnotation> annotation in self.mappaView.annotations){
            atLeastOne = true;
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    if (!atLeastOne) {
        return;
    }

    if ([CLLocationManager locationServicesEnabled]) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, [[MyLocation sharedMyLocation] getUserLocation].longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, [[MyLocation sharedMyLocation] getUserLocation].latitude);
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, [[MyLocation sharedMyLocation] getUserLocation].longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, [[MyLocation sharedMyLocation] getUserLocation].latitude);
    }

    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.2; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.2; // Add a little extra space on the sides
    [self.mappaView setRegion:[self.mappaView regionThatFits:region] animated:animated];
}
