package it.solvingteam.auction.domain;

import it.solvingteam.auction.domain.Bid;
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

privileged aspect Bid_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager Bid.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Bid.id;
    
    @Version
    @Column(name = "version")
    private Integer Bid.version;
    
    public Long Bid.getId() {
        return this.id;
    }
    
    public void Bid.setId(Long id) {
        this.id = id;
    }
    
    public Integer Bid.getVersion() {
        return this.version;
    }
    
    public void Bid.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Bid.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Bid.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Bid attached = this.entityManager.find(Bid.class, this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Bid.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Bid.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Bid merged = this.entityManager.merge(this);
        this.entityManager.flush();
        this.id = merged.getId();
    }
    
    public static final EntityManager Bid.entityManager() {
        EntityManager em = new Bid().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Bid.countBids() {
        return (Long) entityManager().createQuery("select count(o) from Bid o").getSingleResult();
    }
    
    public static List<Bid> Bid.findAllBids() {
        return entityManager().createQuery("select o from Bid o").getResultList();
    }
    
    public static Bid Bid.findBid(Long id) {
        if (id == null) return null;
        return entityManager().find(Bid.class, id);
    }
    
    public static List<Bid> Bid.findBidEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from Bid o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
