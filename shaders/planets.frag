uniform vec4 diffuse = vec4(0.0, 1, 0, 1);
uniform float shine = 128;
uniform vec4 specular = vec4(0.5, 0.5, 1.0, 1.0);
uniform sampler2D grass;
uniform float timer;

in Data{
    vec4 pos;
    vec4 old_pos;
    vec3 n;
    vec3 l_dir;
    vec4 eye;
} DataIn;

out vec4 color;

void main(){
    vec3 n = normalize(DataIn.n);
    vec3 l = normalize(DataIn.l_dir);
    vec3 e = vec3(normalize(DataIn.eye));

    float intensity = max(dot(n,l), 0.0);
    vec4 spec = vec4(0);
    vec4 d = texture(grass, vec2(DataIn.pos.x,DataIn.pos.y));


    float newdist = sqrt(
        DataIn.pos.x * DataIn.pos.x +
        DataIn.pos.y * DataIn.pos.y +
        DataIn.pos.z * DataIn.pos.z
    );
    float olddist = sqrt(
        DataIn.old_pos.x * DataIn.old_pos.x +
        DataIn.old_pos.y * DataIn.old_pos.y +
        DataIn.old_pos.z * DataIn.old_pos.z
    );
    float is_spec = 0; 
    if (newdist - olddist <= 0) {
        d = vec4(0, 0, 0.5, 1);
        is_spec = 1;

        vec2 worley = vec2(0);

        float frequency = 2;
        float amplitude = 0.5;
        float lacunarity = 4.0;
        float persistence = 0.5;

        for (int octave = 0; octave < 3; octave++) {
            worley += amplitude * cellular2x2x2( vec3( frequency * DataIn.pos.xz, timer / 5000) );
            frequency *= lacunarity;
            amplitude *= persistence;
        } 
        float F1 = worley.x;

        if (F1 >= 0.65) d = vec4(1);
        


        //d = d * mix(0, 0.5 + F1 , smoothstep(0.0, 0.003, 1-length(DataIn.pos.xz)));

    }
        
    if (intensity > 0){
        vec3 h = normalize(DataIn.l_dir + e);
        
        float intSpec = max(dot(h,n), 0.0);

        spec = is_spec * specular * pow(intSpec, shine);
    }

    color = (max(intensity, 0.25) * d) + spec;
}
