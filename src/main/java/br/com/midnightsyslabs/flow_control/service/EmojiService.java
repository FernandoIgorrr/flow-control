package br.com.midnightsyslabs.flow_control.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class EmojiService {
    private final Map<Short, String> spantCategoryToEmoji = new HashMap<Short, String>();

    public EmojiService() {
        spantCategoryToEmoji.put((short) 1, "🥛");
        spantCategoryToEmoji.put((short) 2, "👥");
        spantCategoryToEmoji.put((short) 3, "⚡");
        spantCategoryToEmoji.put((short) 4, "💧");
        spantCategoryToEmoji.put((short) 5, "🔧");
        spantCategoryToEmoji.put((short) 6, "🚚");
        spantCategoryToEmoji.put((short) 7, "🧾");
        spantCategoryToEmoji.put((short) 8, "📦");
        spantCategoryToEmoji.put((short) 9, "📌");
    }

    public String getEmoji(Short i){
        return (i > 9 || i < 1) ? "" : spantCategoryToEmoji.get(i);
    }
}
