// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
#define iChannel0 bitmap
#define texture flixel_texture2D

// end of ShadertoyToFlixel header

float Threshold = 0.05; // Default is 0.05
float Intensity = 1.0; // Default is 1.0

vec4 blend(in vec2 Coord, in sampler2D Tex, in float MipBias)
{
	vec2 TexelSize = MipBias/iResolution.xy;

	vec4 Color = texture(Tex, Coord);
    
    // Take 6 samples from the texture (Thanks to Envy24 for optimizing)
    for (float i = 1.; i <= 6.; i += 1.)
    {
        float inv = 1./i;
        Color += texture(Tex, Coord + vec2( TexelSize.x, TexelSize.y)*inv);
        Color += texture(Tex, Coord + vec2(-TexelSize.x, TexelSize.y)*inv);
        Color += texture(Tex, Coord + vec2( TexelSize.x,-TexelSize.y)*inv);
        Color += texture(Tex, Coord + vec2(-TexelSize.x,-TexelSize.y)*inv);
    }
	
    // Original version. This is not optimized.
    /* Color += texture(Tex, Coord + vec2(TexelSize.x,TexelSize.y));
	Color += texture(Tex, Coord + vec2(TexelSize.x/2.0,TexelSize.y/2.0));
	Color += texture(Tex, Coord + vec2(TexelSize.x/3.0,TexelSize.y/3.0));
	Color += texture(Tex, Coord + vec2(TexelSize.x/4.0,TexelSize.y/4.0));
	Color += texture(Tex, Coord + vec2(TexelSize.x/5.0,TexelSize.y/5.0));
	Color += texture(Tex, Coord + vec2(TexelSize.x/6.0,TexelSize.y/6.0));
	Color += texture(Tex, Coord + vec2(-TexelSize.x,TexelSize.y));
	Color += texture(Tex, Coord + vec2(-TexelSize.x/2.0,TexelSize.y/2.0));
	Color += texture(Tex, Coord + vec2(-TexelSize.x/3.0,TexelSize.y/3.0));
	Color += texture(Tex, Coord + vec2(-TexelSize.x/4.0,TexelSize.y/4.0));
	Color += texture(Tex, Coord + vec2(-TexelSize.x/5.0,TexelSize.y/5.0));
	Color += texture(Tex, Coord + vec2(-TexelSize.x/6.0,TexelSize.y/6.0));
	Color += texture(Tex, Coord + vec2(TexelSize.x,-TexelSize.y));
	Color += texture(Tex, Coord + vec2(TexelSize.x/2.0,-TexelSize.y/2.0));
	Color += texture(Tex, Coord + vec2(TexelSize.x/3.0,-TexelSize.y/3.0));
	Color += texture(Tex, Coord + vec2(TexelSize.x/4.0,-TexelSize.y/4.0));
	Color += texture(Tex, Coord + vec2(TexelSize.x/5.0,-TexelSize.y/5.0));
	Color += texture(Tex, Coord + vec2(-TexelSize.x/6.0,-TexelSize.y/6.0));
	Color += texture(Tex, Coord + vec2(-TexelSize.x,-TexelSize.y));
	Color += texture(Tex, Coord + vec2(-TexelSize.x/2.0,-TexelSize.y/2.0));
	Color += texture(Tex, Coord + vec2(-TexelSize.x/3.0,-TexelSize.y/3.0));
	Color += texture(Tex, Coord + vec2(-TexelSize.x/4.0,-TexelSize.y/4.0));
	Color += texture(Tex, Coord + vec2(-TexelSize.x/5.0,-TexelSize.y/5.0));
	Color += texture(Tex, Coord + vec2(TexelSize.x/6.0,-TexelSize.y/6.0)); */

	return Color/24.0;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = (fragCoord.xy/iResolution.xy)*vec2(1.0,1.0);

	vec4 Color = texture(iChannel0, uv);

	vec4 Highlight = clamp(blend(uv, iChannel0, 4.0)-Threshold,0.0,1.0)*1.0/(1.0-Threshold);

	fragColor = 1.0-(1.0-Color)*(1.0-Highlight*Intensity);
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}