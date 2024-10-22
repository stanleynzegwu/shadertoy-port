import * as THREE from "three";
import { Plane, shaderMaterial, useTexture } from "@react-three/drei";
import { useThree, extend, useFrame } from "@react-three/fiber";
import vertexShader from "../shaders/shadertoyPort/plane.vertex.glsl";
import fragmentShader from "../shaders/shadertoyPort/plane.fragment.glsl";
import { useRef } from "react";

export default function ShaderPlane() {
  const ref = useRef();
  const { viewport } = useThree();

  const texture0 = useTexture("/textures/perlin.png");
  const texture1 = useTexture("/textures/perlin.png");
  const texture2 = useTexture("/textures/perlin.png");
  // perlinTexture.wrapS = THREE.RepeatWrapping;
  // perlinTexture.wrapT = THREE.RepeatWrapping;

  const PlaneShaderMaterial = shaderMaterial(
    {
      iTime: 0,
      iResolution: new THREE.Vector3(),
      iChannel0: null,
      iChannel1: null,
      iChannel2: null,
    },
    vertexShader,
    fragmentShader
  );

  // declaratively
  extend({ PlaneShaderMaterial });

  useFrame(({ clock, size }) => {
    ref.current.iTime = clock.getElapsedTime();
    ref.current.iResolution = [size.width, size.height, 1];
  });

  return (
    <Plane args={[viewport.width, viewport.height]}>
      <planeShaderMaterial
        ref={ref}
        iChannel0={texture0}
        iChannel1={texture1}
        iChannel2={texture2}
      />
    </Plane>
  );
}
