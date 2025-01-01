// based on the following Shader Toy entry
//
// [SH17A] Matrix rain. Created by Reinder Nijhoff 2017
// Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
// @reindernijhoff
//
// https://www.shadertoy.com/view/ldjBW1
//
#define BLACK_BLEND_THRESHOLD .25
#define GREEN_ALPHA .15
#define R fract(1e2*sin(p.x*8.+p.y))
void mainImage(out vec4 o,vec2 u) {
  vec3 v=vec3(u,1)/iResolution-.5,
  s=.5/abs(v),
  i=ceil(8e2*(s.z=min(s.y,s.x))*(s.y<s.x?v.xzz:v.zyz)),
  j=fract(i*=.1),
  p=vec3(9,int(iTime*(9.+8.*sin(i-=j).x)),0)+i;
  o-=o,o.g=R/s.z;p*=j;o*=R>.5&&j.x<.6&&j.y<.8?GREEN_ALPHA:0.;

  vec2 uv = u.xy / iResolution.xy;
  vec4 terminalColor = texture(iChannel0, uv);
  float alpha = step(length(terminalColor.rgb), BLACK_BLEND_THRESHOLD);
  vec3 blendedColor = mix(terminalColor.rgb, o.rgb, alpha);
  o = vec4(blendedColor, terminalColor.a);
}
