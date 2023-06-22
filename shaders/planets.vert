uniform mat4 m_view;
uniform mat4 m_pvm;
uniform mat4 m_viewModel;
uniform mat3 m_normal;

uniform int N_OCTAVES = 3; 

uniform vec4 l_dir; 
uniform sampler2D out_pos;

in vec4 position;
in vec3 normal;
in vec2 texCoord0;


// . p3 .
// p2 n p1
// . p4 .

out Data {
    vec4 pos;
    vec4 old_pos;
    vec3 n;
    vec3 l_dir;
    vec4 eye;
} DataOut;

void main(){
    vec4 newpos = texture(out_pos, texCoord0);
    vec4 p1 = texture(out_pos, vec2(texCoord0.x + 1/1000, texCoord0.y));
    vec4 p2 = texture(out_pos, vec2(texCoord0.x - 1/1000, texCoord0.y));
    vec4 p3 = texture(out_pos, vec2(texCoord0.x, texCoord0.y + 1/1000));
    vec4 p4 = texture(out_pos, vec2(texCoord0.x, texCoord0.y - 1/1000));

    vec4 n1 = p1 - p2;
    vec4 n2 = p3 - p4;

    vec3 n = cross(n1.xyz,n2.xyz).xyz;

    DataOut.l_dir = vec3(m_view * -(l_dir));
    DataOut.n = normalize(m_normal*n);
    DataOut.old_pos = position;
    DataOut.pos = newpos; 

    gl_Position = m_pvm * (position + newpos);
} 