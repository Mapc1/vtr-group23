uniform mat4 m_pvm;
uniform mat4 m_viewModel;
uniform mat3 m_normal;

uniform int N_OCTAVES = 20; 

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;

in Data{
    vec3 n;
    vec3 l_dir;
    vec4 eye;
} DataIn[3];

out Data{
    vec4 pos;
    vec4 old_pos;
    vec3 n;
    vec3 l_dir;
    vec4 eye;
} DataOut;


void main(){
    vec4[3] newpos;

    for(int i = 0; i < 3; i++){
        newpos[i] = gl_in[i].gl_Position;
        vec4 norm = vec4(newpos[i].xyz,0);

        float frequency = 1;
        float amplitude = 0.25;
        float lacunarity = 2.0;
        float persistence = 0.5;

        float n = 0;

        for (int octave = 0; octave < N_OCTAVES; octave++) {
            n += amplitude * cnoise(vec4(frequency*newpos[i].x, frequency*newpos[i].y, frequency*newpos[i].z, 1));
            frequency *= lacunarity;
            amplitude *= persistence;
        }
        if (n < 0)
            n = 0;
        
        float frequency_l2 = 3.5;
        float amplitude_l2 = 4;
        float lacunarity_l2 = 2.0;
        float persistence_l2 = 0.5;

        float n2 = amplitude_l2 * cnoise(vec4(frequency_l2*newpos[i].x, frequency_l2*newpos[i].y, frequency_l2*newpos[i].z, 1));
        if (n2 > 0.2)
            n *= n2;

        newpos[i] += norm * n * 0.5;
    }

    vec4 edge1 = newpos[1] - newpos[0];
    vec4 edge2 = newpos[2] - newpos[0];
    vec3 normal = normalize(cross(edge1.xyz, edge2.xyz));

    for(int i = 0; i < 3; i++){
        gl_Position = m_pvm * newpos[i];

        DataOut.pos = newpos[i];
        DataOut.old_pos = gl_in[i].gl_Position;
        DataOut.n = normalize(m_normal * normal);
        DataOut.l_dir = DataIn[i].l_dir;
        DataOut.eye = -(m_viewModel * newpos[i]);

        EmitVertex();
    }
    EndPrimitive();
}