package it.solvingteam.auction.domain;

import it.solvingteam.auction.domain.Item;
import java.lang.Integer;
import java.lang.Long;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PersistenceContext;
import javax.persistence.Version;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Item_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager Item.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Item.id;
    
    @Version
    @Column(name = "version")
    private Integer Item.version;
    
    public Long Item.getId() {
        return this.id;
    }
    
    public void Item.setId(Long id) {
        this.id = id;
    }
    
    public Integer Item.getVersion() {
        return this.version;
    }
    
    public void Item.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Item.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Item.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Item attached = this.entityManager.find(Item.class, this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Item.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Item.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Item merged = this.entityManager.merge(this);
        this.entityManager.flush();
        this.id = merged.getId();
    }
    
    public static final EntityManager Item.entityManager() {
        EntityManager em = new Item().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Item.countItems() {
        return (Long) entityManager().createQuery("select count(o) from Item o").getSingleResult();
    }
    
    public static List<Item> Item.findAllItems() {
        return entityManager().createQuery("select o from Item o").getResultList();
    }
    
    public static Item Item.findItem(Long id) {
        if (id == null) return null;
        return entityManager().find(Item.class, id);
    }
    
    public static List<Item> Item.findItemEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from Item o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
