class Vector {
    float xComponent;
    float yComponent;
    float magnitude, squaredMagnitude;
    float angle;

    Vector(float xc, float yc) {
        setComponents( xc, yc );   
    }
    
    void setComponents( float xc, float yc ) {
        this.xComponent = xc;
        this.yComponent = yc;
        this.magnitude = dist(0,0,xc, yc);
        this.squaredMagnitude = xc*xc + yc*yc;
        this.angle = atan2( this.yComponent, this.xComponent);
    }
    
    void setAngle( float theta ) {
        this.angle = theta;
        this.xComponent = this.magnitude * cos(theta);
        this.yComponent = this.magnitude * sin(theta);
    }
    
    void addTo( Vector v2 ) {
        setComponents( this.xComponent + v2.xComponent, this.yComponent + v2.yComponent);
    }

    
    Vector add( Vector v2 ) {
        return new Vector( this.xComponent + v2.xComponent, this.yComponent + v2.yComponent);
    }
    
    Vector subtract( Vector v2 ) {
        return new Vector( this.xComponent - v2.xComponent, this.yComponent - v2.yComponent);
    }
    
    Vector scalarMultiply( float s ) {
        return new Vector( this.xComponent * s, this.yComponent * s);        
    }
    
    Vector getUnitVector() {
        return this.scalarMultiply( 1/this.magnitude );
    }
    
    float dotProduct( Vector v2 ) {
        return this.xComponent * v2.xComponent + this.yComponent * v2.yComponent;
    }
}