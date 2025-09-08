<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Blender Model on Web</title>
  <style>
    body { margin: 0; }
    canvas { display: block; }
  </style>
</head>
<body>
  <script src="https://cdn.jsdelivr.net/npm/three@0.150.1/build/three.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/three@0.150.1/examples/js/loaders/GLTFLoader.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/three@0.150.1/examples/js/loaders/EXRLoader.js"></script>
  
  <script>
    // สร้าง scene
    const scene = new THREE.Scene();

    // 👇 โหลด HDRI (.exr) เป็น background
    const exrLoader = new THREE.EXRLoader();
    exrLoader.load('./blue_grotto_4k.exr', function(texture) {
        texture.mapping = THREE.EquirectangularReflectionMapping; // ทำให้ wrap รอบฉาก
        scene.background = texture;
        scene.environment = texture; // ให้ material สะท้อนแสงด้วย
    });

    const camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);
    const renderer = new THREE.WebGLRenderer();
    renderer.setSize(window.innerWidth, window.innerHeight);
    document.body.appendChild(renderer.domElement);

    // โหลดโมเดล .glb
    const loader = new THREE.GLTFLoader();
    loader.load('./Fish1.glb', function(gltf) {
        scene.add(gltf.scene);
    }, undefined, function(error) {
        console.error(error);
    });

    // เพิ่มแสง
    const light = new THREE.DirectionalLight(0xffffff, 1);
    light.position.set(2, 2, 5).normalize();
    scene.add(light);

    camera.position.z = 5;

    // loop render
    function animate() {
        requestAnimationFrame(animate);
        renderer.render(scene, camera);
    }
    animate();
  </script>
</body>
</html>
