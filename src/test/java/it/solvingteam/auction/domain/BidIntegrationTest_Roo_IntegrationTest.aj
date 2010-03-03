package it.solvingteam.auction.domain;

import it.solvingteam.auction.domain.BidDataOnDemand;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect BidIntegrationTest_Roo_IntegrationTest {
    
    declare @type: BidIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: BidIntegrationTest: @ContextConfiguration(locations = "classpath:/META-INF/spring/applicationContext.xml");
    
    @Autowired
    private BidDataOnDemand BidIntegrationTest.dod;
    
    @Test
    public void BidIntegrationTest.testCountBids() {
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to initialize correctly", dod.getRandomBid());
        long count = it.solvingteam.auction.domain.Bid.countBids();
        org.junit.Assert.assertTrue("Counter for 'Bid' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void BidIntegrationTest.testFindBid() {
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to initialize correctly", dod.getRandomBid());
        java.lang.Long id = dod.getRandomBid().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to provide an identifier", id);
        it.solvingteam.auction.domain.Bid obj = it.solvingteam.auction.domain.Bid.findBid(id);
        org.junit.Assert.assertNotNull("Find method for 'Bid' illegally returned null for id '" + id + "'", obj);
        org.junit.Assert.assertEquals("Find method for 'Bid' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void BidIntegrationTest.testFindAllBids() {
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to initialize correctly", dod.getRandomBid());
        long count = it.solvingteam.auction.domain.Bid.countBids();
        org.junit.Assert.assertTrue("Too expensive to perform a find all test for 'Bid', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        java.util.List<it.solvingteam.auction.domain.Bid> result = it.solvingteam.auction.domain.Bid.findAllBids();
        org.junit.Assert.assertNotNull("Find all method for 'Bid' illegally returned null", result);
        org.junit.Assert.assertTrue("Find all method for 'Bid' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void BidIntegrationTest.testFindBidEntries() {
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to initialize correctly", dod.getRandomBid());
        long count = it.solvingteam.auction.domain.Bid.countBids();
        if (count > 20) count = 20;
        java.util.List<it.solvingteam.auction.domain.Bid> result = it.solvingteam.auction.domain.Bid.findBidEntries(0, (int)count);
        org.junit.Assert.assertNotNull("Find entries method for 'Bid' illegally returned null", result);
        org.junit.Assert.assertEquals("Find entries method for 'Bid' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    @Transactional
    public void BidIntegrationTest.testFlush() {
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to initialize correctly", dod.getRandomBid());
        java.lang.Long id = dod.getRandomBid().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to provide an identifier", id);
        it.solvingteam.auction.domain.Bid obj = it.solvingteam.auction.domain.Bid.findBid(id);
        org.junit.Assert.assertNotNull("Find method for 'Bid' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyBid(obj);
        java.lang.Integer currentVersion = obj.getVersion();
        obj.flush();
        org.junit.Assert.assertTrue("Version for 'Bid' failed to increment on flush directive", obj.getVersion() > currentVersion || !modified);
    }
    
    @Test
    @Transactional
    public void BidIntegrationTest.testMerge() {
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to initialize correctly", dod.getRandomBid());
        java.lang.Long id = dod.getRandomBid().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to provide an identifier", id);
        it.solvingteam.auction.domain.Bid obj = it.solvingteam.auction.domain.Bid.findBid(id);
        org.junit.Assert.assertNotNull("Find method for 'Bid' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyBid(obj);
        java.lang.Integer currentVersion = obj.getVersion();
        obj.merge();
        obj.flush();
        org.junit.Assert.assertTrue("Version for 'Bid' failed to increment on merge and flush directive", obj.getVersion() > currentVersion || !modified);
    }
    
    @Test
    @Transactional
    public void BidIntegrationTest.testPersist() {
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to initialize correctly", dod.getRandomBid());
        it.solvingteam.auction.domain.Bid obj = dod.getNewTransientBid(Integer.MAX_VALUE);
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to provide a new transient entity", obj);
        org.junit.Assert.assertNull("Expected 'Bid' identifier to be null", obj.getId());
        obj.persist();
        obj.flush();
        org.junit.Assert.assertNotNull("Expected 'Bid' identifier to no longer be null", obj.getId());
    }
    
    @Test
    @Transactional
    public void BidIntegrationTest.testRemove() {
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to initialize correctly", dod.getRandomBid());
        java.lang.Long id = dod.getRandomBid().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Bid' failed to provide an identifier", id);
        it.solvingteam.auction.domain.Bid obj = it.solvingteam.auction.domain.Bid.findBid(id);
        org.junit.Assert.assertNotNull("Find method for 'Bid' illegally returned null for id '" + id + "'", obj);
        obj.remove();
        org.junit.Assert.assertNull("Failed to remove 'Bid' with identifier '" + id + "'", it.solvingteam.auction.domain.Bid.findBid(id));
    }
    
}
