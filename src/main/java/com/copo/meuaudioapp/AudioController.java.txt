package com.copo.meuaudioapp;

import org.springframework.core.io.FileSystemResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@org.springframework.web.bind.annotation.RestController
public class AudioController {

    @GetMapping("/audio")
    public ResponseEntity<FileSystemResource> ouvirAudio() {
        File pasta = new File("audios_salvos");
        if (!pasta.exists()) pasta.mkdirs();

        File[] arquivos = pasta.listFiles((dir, nome) -> nome.endsWith(".3gp"));
        if (arquivos == null || arquivos.length == 0) {
            return ResponseEntity.notFound().build();
        }
        File ultimo = arquivos[arquivos.length - 1];
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType("audio/3gpp"))
                .body(new FileSystemResource(ultimo));
    }

    @PostMapping("/enviar-audio")
    public String receberAudio(@RequestParam("arquivo") MultipartFile arquivo) {
        try {
            File pasta = new File("audios_salvos");
            if (!pasta.exists()) pasta.mkdirs();

            File destino = new File(pasta, arquivo.getOriginalFilename());
            FileOutputStream saida = new FileOutputStream(destino);
            saida.write(arquivo.getBytes());
            saida.close();
            return "Áudio recebido e salvo com sucesso!";
        } catch (IOException e) {
            return "Erro ao salvar: " + e.getMessage();
        }
    }
}