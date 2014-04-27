/////////////////////////////////////////////////////////
// Mode7 effect
//
varying mediump vec2 vTex;
uniform lowp sampler2D samplerFront;

precision highp float;
uniform highp float pos_x;
uniform highp float pos_y;
uniform highp float ang;
uniform highp float pixelWidth;
uniform highp float pixelHeight;
uniform highp float horizon;
uniform highp float fov;
uniform highp float scale_x;
uniform highp float scale_y;


void main(void)
{
    float px = vTex.x-0.5;
    float py = vTex.y-0.5 - horizon - fov;
    float pz = vTex.y-0.5 - horizon;

    //projection
    float sx = px / pz;
    float sy = py / pz;

    float sin_ang = sin(radians(ang));
    float cos_ang = cos(radians(ang));

    float xx = sx * cos_ang - sy * sin_ang + pos_y;
    float yy = sx * sin_ang + sy * cos_ang - pos_x;

    float tx = xx * scale_x;
    float ty = yy * scale_y;

    if (tx > 1.0 || tx < 0.0 || ty > 1.0 || ty < 0.0) {
        gl_FragColor = vec4(0.0,0.0,0.0,0.0);
    } else {
        gl_FragColor = texture2D(samplerFront, vec2(tx, ty));
    }
}
